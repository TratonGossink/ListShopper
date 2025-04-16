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
    
    func uploadProfilePhoto(photo: UIImage, user: User) {
        guard let imageData = photo.jpegData(compressionQuality: 0.1) else {
            print("Failed to convert image to JPEG data")
            return }
        
        let uniqueId = UUID().uuidString
        let storageRef = Storage.storage().reference().child("photo").child("\(uniqueId).jpg")
        
//        newPhotoURL(photoURL: uniqueId, user: user)
        
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading profile image to Storage: \(error.localizedDescription)")
                    return
                }
                
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting profile image download URL: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let downloadURL = url else {
                        print( "Error getting download URL")
                        return
                    }
                    if let existingPhotoURL = user.photo, !existingPhotoURL.isEmpty {
                        self.updatePhotoURL(photoURL: downloadURL.absoluteString, user: user)
                    } else {
                        self.newPhotoURL(photoURL: downloadURL.absoluteString, user: user
                        )
                    }
//                    self.updatePhotoURL(photoURL: downloadURL.absoluteString, user: user)
                    
                    print("Download URL: \(downloadURL.absoluteString)")
                }
            }
        }
    
    func updatePhotoURL(photoURL: String, user: User) {
        let db = Firestore.firestore()
        
        db.collection("users").document(user.id).updateData(["photo": photoURL]) { error in
            if let error = error {
                print("Error updating profile image URL in Firestore: \(error.localizedDescription)")
            } else {
                print("Profile image URL updated successfully in Firestore.")
            }
        }
    }
    
    func newPhotoURL(photoURL: String, user: User) {
        let db = Firestore.firestore()
        
        db.collection("users").document(user.id).setData(["photo": photoURL], merge: true) { error in
            if let error = error {
                print("Error updating profile image URL in Firestore: \(error.localizedDescription)")
            } else {
                print("Profile image URL updated successfully in Firestore.")
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
