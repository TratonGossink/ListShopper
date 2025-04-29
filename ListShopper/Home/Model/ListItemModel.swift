//
//  ListItemModel.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/19/25.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct ListItem: Identifiable, Codable, Equatable {
    var id: String = UUID().uuidString
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isComplete: Bool
    
    mutating func toggleComplete(_ state: Bool) {
        isComplete = state
    }
}
