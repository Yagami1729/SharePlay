//
//  SharePlayApp.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import SwiftUI

@main
struct SharePlayApp: App {
    var model: SharePlayModel = .init()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView(model: model)
            }
            .environment(model)
        }
    }
}
