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
}

struct ContentView: View {
    let logger = Logger(subsystem: "SharePlay", category: "Logic")
    
    var body: some View {
        VStack(spacing: 40) {
            ShareLink(item: URL(string: "https://apple.com")!)
            Button("Activate") {
                activateSession()
            }
            Button("Join") {
                joinSession()
            }
        }
    }
}

private extension ContentView {
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
//                let messenger = GroupSessionMessenger(session: session, deliveryMode: .reliable)
//                for await (message, context) in messenger.messages(of: GameMessage.self) { }
            }
        }
    }
}

#Preview {
    ContentView()
}
