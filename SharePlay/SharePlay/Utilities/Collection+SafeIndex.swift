//
//  Collection+SafeIndex.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        self.indices.contains(index) ? self[index] : nil
    }
}
