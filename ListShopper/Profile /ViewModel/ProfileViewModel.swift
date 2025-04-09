//
//  ProfileViewModel.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/18/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String = ""
    
    let db  = Firestore.firestore()
    let storage  = Storage.storage().reference()
    
    init() {
        fetchUser()
    }
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users")
            .document(userId)
            .getDocument { [weak self] snapshot, error in guard let self = self, let snapshot = snapshot, error == nil
            else { return }
            
            if let user = try? snapshot.data(as: User.self) {
                DispatchQueue.main.async {
                    self.user = user
                }
            }
        }
    }
    
    func uploadProfileImage(photo: UIImage) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in or no user ID found.")
            return }
        guard let imageData = photo.jpegData(compressionQuality: 0.4) else { return }
        
        let profileRef = storage.child("users/\(userId)/photo")
        
        profileRef.putData(imageData, metadata: nil) { [weak self] _, error in
            guard let self = self else { return }
            if let error = error {
                print("Upload error: \(error.localizedDescription)")
                return
            }
            
            profileRef.downloadURL { [weak self] url, error in
                guard let self = self, let downloadURL = url else {
                    print("Failed to get download URL")
                    return
                }
                
                print("Download URL: \(downloadURL.absoluteString)")
                
                self.db.collection("users").document(userId).updateData(["photo": downloadURL.absoluteString]) { error in
                    if let error = error {
                        print("Error updating profile image URL: \(error.localizedDescription)")
                    } else {
                        DispatchQueue.main.async {
                            self.user?.photo = downloadURL.absoluteString
                        }
                    }
                }
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.user = nil
            }
        } catch {
            print("Error signing out: \(error)")
        }
    }
    
    
    static func verifyCode(code: String, completion: @escaping (Error?) -> Void) {
        
        let verificationId = UserDefaults.standard.string(forKey: "authverificationID" ) ?? ""
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            
            DispatchQueue.main.async {
                completion(error)
            }
        }
        
    }
}
