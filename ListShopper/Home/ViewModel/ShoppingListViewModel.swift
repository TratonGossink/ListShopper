//
//  HomeViewModel.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/19/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ShoppingListViewModel: ObservableObject {

    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?

    init (userId: String) {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        } 
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }

}

