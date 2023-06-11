//
//  Questions.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import Foundation
import Observation

struct Question: Codable, Identifiable, Hashable {
    let id: UUID
    var title: String = ""
    var options: [Option] = []
    var correctOption: Option? = nil
    var user: String = ""
    
    var isValid: Bool {
        !self.title.isEmpty &&
          !options.isEmpty &&
          correctOption != nil &&
          !user.isEmpty
    }
    
    init(id: UUID = .init(), title: String, options: [Option] = [.init(title: "")], correctOption: Option? = nil, user: String) {
        self.id = id
        self.title = title
        self.options = options
        self.correctOption = correctOption ?? options[safe: 0]
        self.user = user
    }
}

struct Option: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    
    init(title: String) {
        self.id = .init()
        self.title = title
    }
}
