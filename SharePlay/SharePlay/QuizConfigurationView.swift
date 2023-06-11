//
//  QuizConfigurationView.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import SwiftUI
import Observation

struct QuizConfigurationView: View {
    @Binding var configuration: QuizConfiguration
    @Environment(SharePlayModel.self) var model
    
    var questionLimitRange: ClosedRange<Int> = 1...10
    var timeLimitRange: ClosedRange<Int> = 1...10
    
    var session: Session {
        Session(id: .init(), configuration: configuration)
    }
    
    var body: some View {
        Form {
            Section {
                Picker("No. of Questions", selection: $configuration.totalQuestions) {
                    ForEach(Array(questionLimitRange), id: \.self) { limit in
                        Text("\(limit)")
                    }
                }
                Picker("Time Limit", selection: $configuration.timeLimit) {
                    ForEach(Array(timeLimitRange), id: \.self) { limit in
                        Text("^[\(limit) second](inflect: true)")
                    }
                }
            } header: {
                Text("Quiz Configuration")
            }
        }
        .safeAreaPadding(.init(top: 16, leading: 16, bottom: 16, trailing: 16))
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button {
                    model.activateSession()
                } label: {
                    Text("Start")
                }
                ShareLink(
                    item: session,
                    subject: Text("Come on, have an awesome fun quiz!"),
                    preview: SharePreview(Text("Share~Play"), icon: Image(systemName: "lightbulb.max.fill")))
                .labelStyle(.titleAndIcon)
                .imageScale(.large)
                .symbolVariant(.fill)
            }
            .buttonStyle(.borderedProminent)
            .disabled(configuration.hostUser.name.isEmpty)
        }
        .navigationTitle("Configure Quiz")
    }
}

#Preview {
    NavigationStack {
        QuizConfigurationView(configuration: .constant(QuizConfiguration(hostUser: .init(name:"James"))))
    }
}
