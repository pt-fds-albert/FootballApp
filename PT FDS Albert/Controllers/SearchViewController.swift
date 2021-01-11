//
//  SearchViewController.swift
//  PT FDS Albert
//
//  Created by Albert on 10/1/21.
//

import UIKit
import Nuke
import Loaf
import Lottie

class SearchViewController: UIViewController {
    // MARK: - PROPERTIES
    let networkManager = NetworkManager()
    var players: [PlayerTuple] = [] {
        didSet {
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    var animationView: AnimationView?
    
    // MARK: - OUTLETS
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.placeholder = "search.placeholder".fromFile("Main")
        }
    }
    
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.setTitle("search".fromFile("Main"), for: UIControl.State())
            searchButton.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
            searchTableView.separatorStyle = .none
        }
    }
    
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: - FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loading view
        animationView = .init(name: "ballAnimation")
        if let animationView = animationView {
            showLoadingView(false)
            animationView.frame = loadingView.bounds
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            loadingView.addSubview(animationView)
        }
        
        // Register cell
        let playerCell = UINib(nibName: "PlayerCell", bundle: nil)
        searchTableView.register(playerCell, forCellReuseIdentifier: "PlayerCell")
    }
    
    private func showLoadingView(_ show: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = !show
            if show {
                self.animationView?.play()
            } else {
                self.animationView?.stop()
            }
        }
    }
    
    private func showMessage(_ message: String, type: Loaf.State) {
        DispatchQueue.main.async {
            Loaf(message, state: type, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
        }
    }
    
    // MARK: - ACTIONS
    @IBAction func searchAction(_ sender: UIButton) {
        view.endEditing(true)
        showLoadingView(true)
        players.removeAll()
        
        if let query = self.searchTextField.text, query.count > 0 {
            self.networkManager.getPlayersByName(name: query) { (players, error) in
                guard let players = players, players.count > 0, error == nil else {
                    self.showMessage("no.results".fromFile("Main"), type: .error)
                    self.showLoadingView(false)
                    return
                }
                
                self.players = players
                self.showLoadingView(false)
            }
            self.searchTextField.text = nil
        } else {
            showMessage("input.empty".fromFile("Main"), type: .error)
            self.showLoadingView(false)
        }
    }
}

// MARK: - EXTENSIONS
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.modalPresentationStyle = .fullScreen
        
        let playerID = players[indexPath.row].id
        
        detailViewController.playerID = playerID
        
        navigationController?.pushViewController(detailViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        
        cell.prepareForReuse()
        
        let player = players[indexPath.row]
        
        cell.nameLabel.text = player.name
        
        if let birthDate = player.birthdate, !birthDate.isEmpty {
            cell.ageLabel.text = String(format: "years.old".fromFile("Main"), Utils.currentAge(birthDate: birthDate, dateFormat: "dd/MM/yyyy"))
        } else {
            cell.ageLabel.text = "birthdate.not.found".fromFile("Main")
        }
        
        if let url = URL(string: player.imageUrl) {
            Nuke.loadImage(with: url, into: cell.playerImageView)
        }
        
        return cell
    }
    
    
}
