//
//  RootView.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import SwiftUI

struct RootView: View {
    @Bindable var model: SharePlayModel
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "lightbulb.max.fill")
                .font(.system(size: 120))
                .foregroundStyle(Color.accentColor.gradient)
                .overlay {
                    Text("🧠")
                        .font(.largeTitle)
                        .offset(y: -12)
                }
                .padding()
            
            Text("Welcome to")
            Text("Share~Play Quiz")
                .font(.largeTitle)
                .bold()
            Spacer()
            
            TextField("Host name", text: $model.configuration.hostUser)
                .padding(.horizontal, 26)
                .padding(.vertical)
                .background {
                    Capsule(style: .continuous)
                        .fill(Color.clear)
                        .strokeBorder(Color.accentColor.gradient, lineWidth: 4)
                }
                .padding()
            NavigationLink {
                QuizConfigurationView(configuration: $model.configuration)
            } label: {
                Text("Configure")
            }
            .buttonStyle(.borderedProminent)
            .disabled(model.configuration.hostUser.isEmpty)
            Spacer()
        }
        .fontDesign(.rounded)
    }
}

#Preview {
    NavigationStack {
        RootView(model: SharePlayModel())
    }
}

