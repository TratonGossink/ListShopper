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
    @Published var showAlert: Bool = false
    @Published var isSheetPresented: Bool = false
    
    var id: String
    
    init(listItem: ListItem? = nil) {
        if let listItem = listItem {
            self.title = listItem.title
            self.dueDate = Date(timeIntervalSince1970: listItem.dueDate)
            self.id = listItem.id
        } else {
            self.id = UUID().uuidString
        }
    }
    
    func save() {
        guard self.canSave else { return }
        
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print(#function, "Could not get user ID")
            return
        }
        
        let itemId = UUID().uuidString
        let itemData = ListItem(
            id: itemId,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isComplete: false)
        
            let data = itemData.asDictionary()
            db.collection("users")
                .document(userID)
                .collection("lists")
                .document(itemId)
                .setData(data) { error in
                    if let error = error {
                        print(#function, "Error saving data: \(error)")
                        self.showAlert = true
                    }
                }
            print(#function, "Could not convert to dictionary")
        }

    func deleteItem() {
        let db = Firestore.firestore()
        
        guard let userId = Auth.auth().currentUser?.uid else {
                 print(#function, "Could not get user ID")
                 return
             }
        
        db.collection("users")
            .document(userId)
            .collection("lists")
            .document(id)
            .delete() {
                error in
                if let error = error {
                    print("Error deleting document: \(error.localizedDescription)")
                } else {
                    print( "Item successfully deleted")
                }
            }
    }
    
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print(#function, "Title must not be empty")
            return false }
        
        guard dueDate > Date() else {
            print(#function, "Due date must be in the future")
            return false
        }
        return true
    }
}
