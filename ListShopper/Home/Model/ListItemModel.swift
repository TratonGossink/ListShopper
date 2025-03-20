//
//  ListItemModel.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/19/25.
//

import Foundation

struct ListItem: Identifiable, Codable {
    var id: String = UUID().uuidString
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isComplete: Bool
    
    mutating func toggleComplete(_ state: Bool) {
        isComplete = state
    }
}
