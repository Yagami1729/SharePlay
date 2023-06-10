//
//  LaunchScreen.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "lightbulb.max.fill")
                .font(.system(size: 120))
                .padding(.bottom)
                .foregroundStyle(Color.yellow.gradient)
                .overlay {
                    Text("🧠")
                        .font(.largeTitle)
                        .offset(y: -16)
                }
            
            Text("Welcome to")
            Text("Share~Play")
                .font(.largeTitle)
                .bold()
        }
        .fontDesign(.rounded)
        .padding()
    }
}

#Preview {
    LaunchScreen()
}
