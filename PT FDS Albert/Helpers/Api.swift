//
//  Api.swift
//  PT FDS Albert
//
//  Created by Albert on 10/1/21.
//

import Foundation

struct Api {
    static let token = "ApIWxwUmq6QeuMRmJU41sfqQoHz12ZVFiwfEiaqVDdoNeIWCaIroUDwVN4jw"
    
    struct url {
        static let base = "https://soccer.sportmonks.com/api/v2.0/"
        
        static let playersByName = "players/search/%@"
        static let playerByID =  "players/%d"
        
        static let teamByID = "teams/%d"
    }
    
}

