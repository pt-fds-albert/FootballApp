//
//  Player.swift
//  PT FDS Albert
//
//  Created by Albert on 10/1/21.
//

import Foundation
import SwiftyJSON

struct Player {
    let shortName: String
    let fullName: String
    let imageUrl: String
    let nationality: String
    let birthDate: String?
    let weight: String?
    let height: String?
    let team: Team?
    
    init(_ player: JSON, team: Team?) {
        self.shortName = player["common_name"].stringValue
        self.fullName = player["display_name"].stringValue
        self.imageUrl = player["image_path"].stringValue
        self.nationality = player["nationality"].stringValue
        self.birthDate = player["birthdate"].string
        self.weight = player["weight"].string
        self.height = player["height"].string
        self.team = team
        
    }
}
