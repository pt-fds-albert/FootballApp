//
//  NetworkManager.swift
//  PT FDS Albert
//
//  Created by Albert on 10/1/21.
//

import Foundation
import SwiftyJSON

class NetworkManager {
    
    func getTeamByID(id: Int, completionHandler: @escaping (Team?, Error?) -> Void) {
        let urlSession = URLSession(configuration: .default)
        
        guard let url = URL(string: Api.url.base + String(format: Api.url.teamByID, id) + "?api_token=\(Api.token)")  else { return }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil, response.statusCode == 200 else { return }
            
            do {
                let teamJSON = try JSON(data: data)["data"]

                let team = Team(teamJSON)
                
                completionHandler(team, nil)
                
            } catch let error {
                completionHandler(nil, error)
            }
            
        }.resume()
    }
    
    func getPlayerByID(id: Int, completionHandler: @escaping (Player?, Error?) -> Void) {
        let urlSession = URLSession(configuration: .default)
        
        guard let url = URL(string: Api.url.base + String(format: Api.url.playerByID, id) + "?api_token=\(Api.token)")  else { return }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil, response.statusCode == 200 else { return }
            
            do {
                let playerJSON = try JSON(data: data)["data"]
                
                self.getTeamByID(id: playerJSON["team_id"].intValue) { (team, error) in
                    
                    let player = Player(playerJSON, team: team)
                    
                    completionHandler(player, nil)
                }

                
            } catch let error {
                completionHandler(nil, error)
            }
            
        }.resume()
    }
    
    func getPlayersByName(name: String, completionHandler: @escaping ([PlayerTuple]?, Error?) -> Void) {
        
        let urlSession = URLSession(configuration: .default)
        
        guard let url = URL(string: Api.url.base + String(format: Api.url.playersByName, name) + "?api_token=\(Api.token)")  else { return }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil, response.statusCode == 200 else { return }
            
            do {
                var players: [PlayerTuple] = []
                let playersJSON = try JSON(data: data)["data"].arrayValue
                
                for player in playersJSON {
                    players.append((player["player_id"].intValue, player["display_name"].stringValue, player["image_path"].stringValue, player["birthdate"].stringValue))
                }
                
                completionHandler(players, nil)
                
            } catch let error {
                completionHandler(nil, error)
            }
            
        }.resume()
        
    }
}
