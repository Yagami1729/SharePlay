//
//  User.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import Foundation

struct User: Codable {
    let id: UUID
    var name: String
    
    init(id: UUID = .init(), name: String) {
        self.id = id
        self.name = name
    }
}
