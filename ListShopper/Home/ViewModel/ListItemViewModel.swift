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
    
    @Published var itemId: UUID?
    @Published var title: String = ""
    @Published var dueDate: Date = Date()
    @Published var showAlert: Bool = false
    @Published var isSheetPresented: Bool = false
    
    var id: String
    let itemUUID = UUID().uuidString
    
    init(listItem: ListItem? = nil) {
        if let listItem = listItem {
            self.title = listItem.title
            self.dueDate = Date(timeIntervalSince1970: listItem.dueDate)
            self.id = itemUUID
        } else {
            self.id = UUID().uuidString
        }
    }
    
    func save() {
        guard self.canSave else { return }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print(#function, "Could not get user ID")
            return
        }
        
        let itemData = ListItem(
            id: itemUUID,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isComplete: false)
        
        let db = Firestore.firestore()
            db.collection("users")
                .document(userId)
                .collection("listItems")
                .document(itemUUID)
                .setData(itemData.asDictionary()) { error in
                    if let error = error {
                        print(#function, "Error saving data: \(error)")
                        self.showAlert = true
                    }
                }
            print(#function, "Could not convert to dictionary")
        print("Item as dictionary: \(itemData.asDictionary())")
        }

    func deleteListItem() {
        let db = Firestore.firestore()
        
        let itemData = ListItem(
            id: itemUUID,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isComplete: false)
        
        guard let userId = Auth.auth().currentUser?.uid else {
                 print(#function, "Could not get user ID")
                 return
             }
        
        db.collection("users")
            .document(userId)
            .collection("listItems")
            .document(itemUUID)
            .delete() {
                error in
                if let error = error {
                    print("Error deleting document: \(error.localizedDescription)")
                } else {
                    print("Item successfully deleted")
                }
            }
    }
    
    func editListItem() {
            guard self.canSave else { return }
            
            guard let userId = Auth.auth().currentUser?.uid else {
                print(#function, "Could not get user ID")
                return
            }
            
            let itemData = ListItem(
                id: itemUUID,
                title: title,
                dueDate: dueDate.timeIntervalSince1970,
                createdDate: Date().timeIntervalSince1970,
                isComplete: false)
            
            let db = Firestore.firestore()
                db.collection("users")
                    .document(userId)
                    .collection("listItems")
                    .document(itemUUID)
                    .updateData(itemData.asDictionary()) { error in
                        if let error = error {
                            print(#function, "Error saving data: \(error)")
                            self.showAlert = true
                        }
                    }
                print(#function, "Could not convert to dictionary")
            print("Item as dictionary: \(itemData.asDictionary())")
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
    
    func toggleIsComplete(item: ListItem) {
//        item.toggleComplete(true)
        
    }
}
