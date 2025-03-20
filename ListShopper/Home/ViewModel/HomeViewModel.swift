//
//  HomeViewModel.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/19/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    
    @Published var showingNewItemView = false
    
    private let userId: String
    
    init (userId: String) {
        self.userId = userId
    }
    
    func deleteItem(id: ListItem.ID) {
        let db = Firestore.firestore()
        
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
}

