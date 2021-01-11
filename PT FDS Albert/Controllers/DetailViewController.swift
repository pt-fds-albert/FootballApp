//
//  DetailViewController.swift
//  PT FDS Albert
//
//  Created by Albert on 11/1/21.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    
    // MARK: - PROPERTIES
    let netorkManager = NetworkManager()
    var playerID: Int?
    
    // MARK: - OUTLETS
    @IBOutlet weak var playerImageView: UIImageView! {
        didSet {
            playerImageView.image = nil
        }
    }
    
    @IBOutlet weak var playerNameLabel: UILabel! {
        didSet {
            playerNameLabel.text = nil
        }
    }
    @IBOutlet weak var nationalityLabel: UILabel! {
        didSet {
            nationalityLabel.text = nil
        }
    }
    
    @IBOutlet weak var birthDateLabel: UILabel! {
        didSet {
            birthDateLabel.text = nil
        }
    }
    
    @IBOutlet weak var ageLabel: UILabel! {
        didSet {
            ageLabel.text = nil
        }
    }
    
    @IBOutlet weak var heightLabel: UILabel! {
        didSet {
            heightLabel.text = nil
        }
    }
    
    @IBOutlet weak var weightLabel: UILabel! {
        didSet {
            weightLabel.text = nil
        }
    }
    
    @IBOutlet weak var teamImageView: UIImageView! {
        didSet {
            teamImageView.image = nil
        }
    }
    
    @IBOutlet weak var teamNameLabel: UILabel! {
        didSet {
            teamNameLabel.text = nil
        }
    }
    
    // MARK: - FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let playerID = playerID {
            netorkManager.getPlayerByID(id: playerID) { (player, error) in
                guard let player = player, error == nil else { return }
                DispatchQueue.main.async {
                    self.title = player.shortName
                    if let url = URL(string: player.imageUrl) {
                        Nuke.loadImage(with: url, into: self.playerImageView)
                    }
                    self.playerNameLabel.text = player.fullName
                    self.nationalityLabel.text = player.nationality
                    if let birthDate = player.birthDate {
                        self.birthDateLabel.text = player.birthDate
                        self.ageLabel.text = "(\(String(format: "years.old".fromFile("Main"), Utils.currentAge(birthDate: birthDate, dateFormat: "dd/MM/yyyy"))))"
                    } else {
                        self.birthDateLabel.text = "birthdate.not.found".fromFile("Main")
                    }
                    if let height = player.height {
                        self.heightLabel.text = height
                    } else {
                        self.heightLabel.text = "height.not.found".fromFile("Main")
                    }
                    if let weight = player.weight {
                        self.weightLabel.text = weight
                    }else {
                        self.weightLabel.text = "weight.not.found".fromFile("Main")
                    }
                    if let team = player.team {
                        if let url = URL(string: team.imageUrl) {
                            Nuke.loadImage(with: url, into: self.teamImageView)
                        }
                        self.teamNameLabel.text = team.name
                    }
                }
            }
        }
    }
    // MARK: - ACTIONS

}
