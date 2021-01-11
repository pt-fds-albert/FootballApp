//
//  Extensions.swift
//  PT FDS Albert
//
//  Created by Albert on 10/1/21.
//

import Foundation

extension String {
    func fromFile(_ tableName: String) -> String {
        return NSLocalizedString(self, tableName: tableName, comment: "")
    }
}
