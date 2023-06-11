//
//  QuizPhase.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import Foundation

enum QuizEvent: Codable {
    case ready
    case questionsTimerStarts
    case question(Question)
    case poll(Answer)
    case pollCompleted
}
