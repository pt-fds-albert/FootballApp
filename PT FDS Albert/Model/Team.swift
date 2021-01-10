//
//  Team.swift
//  PT FDS Albert
//
//  Created by Albert on 10/1/21.
//

import Foundation
import SwiftyJSON

struct Team {
    let name: String
    let imageUrl: String
    
    init(_ json: JSON) {
        self.name = json["name"].stringValue
        self.imageUrl = json["logo_path"].stringValue
    }
}
