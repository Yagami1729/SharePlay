//
//  PlayTogether.swift
//  SharePlay
//
//  Created by Kiarash Asar on 6/10/23.
//

import Foundation
import GroupActivities

struct PlayTogether: GroupActivity {
    var configuration: QuizConfiguration
    
    var metadata: GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        metadata.title = "Share Play"
        metadata.type = .exploreTogether
        return metadata
    }
}
