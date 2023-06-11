//
//  Answer.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import Foundation

struct Answer: Codable, Hashable, Identifiable {
    let id: UUID
    var question: Question
    var user: String
    var remainingTime: TimeInterval
}
