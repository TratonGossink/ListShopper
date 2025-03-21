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
    
    init() {
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
        
        do {
            let data = try itemData.asDictionary()
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
        } catch {
            print(#function, "Could not convert to dictionary")
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
