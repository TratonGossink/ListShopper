//
//  RegistrationViewModel.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/17/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegistrationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String = ""
    
    @Published private var isErrorVisible: Bool = false
    @Published var isRegistering: Bool = false
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
                return
            }
            guard let userId = result?.user.uid else {
                print("Failed to get user id.")
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to create user."
                }
                return
            }
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary()) { [weak self] error in
                if let error = error {
                    DispatchQueue.main.async {
                        self?.errorMessage = error.localizedDescription
                        print("Unable to create user.")
                    }
                    return
                }
                DispatchQueue.main.async {
                    self?.errorMessage = "User successfully created!"
                }
            }
    }
    
    func validate() -> Bool {
        var validEntry = true
        var errorMessage: [String] = []
        //         errorMessage = ""
        
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            //             errorMessage = "Please enter a name"
            //            errorMessage.append("Please enter a name")
            return false
        }
        
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            //             errorMessage.append("Please enter a valid email address")
            //             validEntry = false
        } else if !email.contains("@") || !email.contains(".") {
            errorMessage.append("Please enter a valid email address")
            validEntry = false
        }
        
        if !password.trimmingCharacters(in: .whitespaces).isEmpty {
            //             errorMessage.append("Please enter a password")
            //             validEntry = false
        } else if password.count >= 6 {
            //                 errorMessage.append("Please enter a password")
            //                 validEntry = false
        }
        
        if !confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty {
            //             errorMessage.append("Please confirm your password")
            //             validEntry = false
        } else if confirmPassword.count >= 6 {
            //             errorMessage.append("Please confirm your password")
            //             validEntry = false
        }
        
        print("Validate attempted")
        return validEntry
        
    }
    
    func clearErrorMessage() {
        errorMessage = ""
    }
}


