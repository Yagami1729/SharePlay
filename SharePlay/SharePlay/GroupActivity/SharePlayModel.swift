//
//  SharePlayModel.swift
//  SharePlay
//
//  Created by Kiarash Asar on 6/10/23.
//

import GroupActivities
import SwiftUI
import Observation
import OSLog

@Observable
class SharePlayModel {
    var messenger: GroupSessionMessenger? = nil
    var configuration: QuizConfiguration = .init()
    var session: GroupSession<PlayTogether>? = nil
    
    var currentEvent: QuizEvent? = nil
    var questions: [Question] = []
    var answers: [Answer] = []
    
    private let logger = Logger(subsystem: "SharePlay", category: "Logic")
    
    func listenForSessions() {
        Task {
            for await session in PlayTogether.sessions() {
                if session.activity.configuration.hostUser.id != self.configuration.hostUser.id {
                    self.configuration = session.activity.configuration
                }
                self.session = session
                session.join()
                self.messenger = GroupSessionMessenger(session: session, deliveryMode: .reliable)
                
                for await (event, context) in messenger!.messages(of: QuizEvent.self) {
                    Task { @MainActor in
                        self.process(event: event)
                    }
                    logger.debug("Context: \(context.source)")
                }
            }
        }
    }
    
    func activateSession() {
        Task {
            do {
                _ = try await PlayTogether(configuration: self.configuration).activate()
            } catch {
                logger.debug("Failed to activate SharePlay: \(error)")
            }
        }
    }
    
    func sendMessage() {
        let gameMessage = GameMessage(id: UUID(), text: "something", timestamp: Date())
        self.messenger?.send(gameMessage, completion: { [weak self] error in
            if let error = error {
                self?.logger.error("Failed sending message with error: \(error)")
            } else {
                self?.logger.debug("Game Message sent successfully")
            }
        })
    }
    
    func process(event: QuizEvent) {
        self.currentEvent = event
        switch event {
        case .ready:
            self.questions.removeAll()
            self.answers.removeAll()
            break
        case .questionsTimerStarts:
            break
        case .question(let question):
            self.questions.append(question)
            break
        case .poll(let answer):
            self.answers.append(answer)
            break
        case .pollCompleted:
            // TODO: Save to disc
            break
        }
    }
}
