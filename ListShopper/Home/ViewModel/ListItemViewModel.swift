//
//  ListItemViewModel.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/20/25.
//

import Foundation
import Firebase
import FirebaseAuth

class ListItemViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var dueDate: Date = Date()
    @Published var createdDate: Date = Date()
    @Published var showAlert: Bool = false
    
    var id: String
    var isEditing: Bool

    init(listItem: ListItem? = nil) {
        if let listItem = listItem {
            self.title = listItem.title
            self.dueDate = Date(timeIntervalSince1970: listItem.dueDate)
            self.id = listItem.id
            self.isEditing = true
        } else {
            self.id = UUID().uuidString
            self.isEditing = false
        }
    }
    
    func save() {
        guard self.canSave else { return }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print(#function, "Could not get user ID")
            return
        }
        
        let itemData = ListItem(
            id: id,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isComplete: false)
        
            Firestore.firestore()
            .collection("users")
                .document(userId)
                .collection("listItems")
                .document(id)
                .setData(itemData.asDictionary()) { error in
                    if let error = error {
                        print(#function, "Error saving/updating data: \(error)")
                        self.showAlert = true
                    }
                }
            print(#function, "Could not convert to dictionary")
        print("Item as dictionary: \(itemData.asDictionary())")
        }
    
    func toggleIsComplete(item: ListItem) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print(#function, "Could not get user ID")
            return
        }
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("listItems")
            .document(item.id)
            .updateData(["isComplete": !item.isComplete]) { error in
                if let error = error {
                    print(#function, "Error saving/updating data: \(error)")
                    self.showAlert = true
                } else {
                    print(#function, "Item complete, toggled successfully.")
                }
            }
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print(#function, "Title must not be empty")
            return false }
        
        guard dueDate > Date().addingTimeInterval(-86400) else {
            print(#function, "Due date must be in the future")
            return false
        }
        return true
    }
}
