//
//  MainViewViewModel.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/17/25.
//

import Foundation
import FirebaseAuth

//class MainViewViewModel: ObservableObject {
//    
//    @Published var currentUserId: String = ""
//    
//    private var handler: AuthStateDidChangeListenerHandle?
//    
//    init() {
//        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
//            DispatchQueue.main.async {
//                self?.currentUserId = user?.uid ?? ""
//            }
//        }
//    }
//    
//    public var isSignedIn: Bool {
//        return Auth.auth().currentUser != nil
//    }
//}
