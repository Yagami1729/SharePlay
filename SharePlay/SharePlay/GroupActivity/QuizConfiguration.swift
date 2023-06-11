//
//  QuizConfiguration.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import Observation
import UniformTypeIdentifiers
import SwiftUI

struct QuizConfiguration: Codable {
    /// Total Number of question to play for each player in a quiz session.
    var totalQuestions: Int = 1
    
    /// Time limit to submit total number of questions in seconds.
    var timeLimit: Int = 4
    
    /// Name of the user that will host and configure the quiz session
    var hostUser: User = User(name: "")
    
    init(totalQuestions: Int = 1, timeLimit: Int = 4, hostUser: User = .init(name: "")) {
        self.totalQuestions = totalQuestions
        self.timeLimit = timeLimit
        self.hostUser = hostUser
    }
}

struct Session: Codable, Transferable {
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: Self.self, contentType: .data)
    }
    
    let id: UUID
    let configuration: QuizConfiguration
}
