//
//  ContentView.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import GroupActivities
import SwiftUI
import OSLog

struct GameMessage: Codable, Identifiable {
    let id: UUID
    let text: String
    let timestamp: Date
}

struct ContentView: View {
    let logger = Logger(subsystem: "SharePlay", category: "Logic")
    @State private var message = ""
    @State private var messagesHistory: [GameMessage] = []
    @State private var model = SharePlayModel()
    
    var body: some View {
        VStack(spacing: 40) {
            ShareLink(item: URL(string: "https://apple.com")!) {
                Text("Share Link")
            }
            Button("Activate") {
                activateSession()
            }
            Button("Join") {
                joinSession()
            }
            Button("Fetch Messages") {
                fetchMessages()
            }
            
            TextField("Message", text: $message)
                .padding()
            Button("Send") {
                sendMessage()
            }
            List {
                ForEach(messagesHistory) { message in
                    let timestamp = dateFormatter.string(from: message.timestamp)
                    Text("\(timestamp): \(message.text)")
                }
            }
        }
    }
}

private extension ContentView {
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/y h:mm a"
        return dateFormatter
    }
    func activateSession() {
        Task {
            do {
                _ = try await PlayTogether().activate()
            } catch {
                logger.log("Failed to activate SharePlay: \(error)")
            }
        }
    }
    func joinSession() {
        Task {
            for await session in PlayTogether.sessions() {
                session.join()
                model.messenger = GroupSessionMessenger(session: session, deliveryMode: .reliable)
                for await (message, context) in model.messenger!.messages(of: GameMessage.self) {
                    Task { @MainActor in
                        messagesHistory.append(message)
                    }
                    logger.debug("Message: \(message.text)")
                    logger.debug("Context: \(context.source)")
                }
            }
        }
    }
    func fetchMessages() {
        Task {
            for await (message, context) in model.messenger!.messages(of: GameMessage.self) {
                Task { @MainActor in
                    messagesHistory.append(message)
                }
                logger.debug("Message: \(message.text)")
                logger.debug("Context: \(context.source)")
            }
        }
    }
    func sendMessage() {
        let gameMessage = GameMessage(id: UUID(), text: message, timestamp: Date())
        model.messenger?.send(gameMessage, completion: { error in
            if let error = error {
                logger.error("Failed sending message with error: \(error)")
            } else {
                logger.debug("Game Message sent successfully")
            }
        })
    }
}

#Preview {
    ContentView()
}
