//
//  LogInViewModel.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/17/25.
//

import Foundation
import FirebaseAuth

class LogInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
//    @Published private var isErrorVisible: Bool = false
    
    init() {}
    
    func logIn() {
        guard validate() else { return }
        
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validate() -> Bool {
        
//        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter a username and password."
//            isErrorVisible = true
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email address"
            return false
        }
        return true
    }
}
