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
    
    func uploadProfileImage2(photo: UIImage?, user: User) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in or no user ID found.")
            return }
        
        let doc = db.collection("users").document(userId)
        
        guard let imageData = photo!.jpegData(compressionQuality: 0.4) else { print("Failed to convert image to data.")
            return }
        
        let storageRef = storage.child("users/\(userId)/profileIMG.jpg")
//        let storageRef = Storage.storage().reference(withPath: "users/\(userId)/photo.jpg")
        print("Upload to: \(storageRef.fullPath)")
        
        storageRef.putData(imageData, metadata: nil) { [weak self] _, error in
            guard let self = self else { return }
            if let error = error {
                
                print("Upload error: \(error.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { [weak self] url, error in
                guard let self = self, let downloadURL = url else {
                    print("Failed to get download URL")
                    return
                }
//            storageRef.downloadURL { [weak self] url, error in
//                if let self = self, let downloadURL = url {
//                    doc.setData(["photo": url!.absoluteString], merge: true) { error in
//                        if error == nil {
//
//                        }
//                    }
//                    print("Download URL: \(downloadURL.absoluteString)")
//                    print("Failed to get download URL")
//                    return
//                }
//            }

                storageRef.downloadURL { [weak self] url, error in
                    guard let self = self, let downloadURL = url else {
                        print("Failed to get download URL: \(error?.localizedDescription ?? "No error")")
                              return
                    }
                    self.updatePhotoURL(photoURL: downloadURL.absoluteString, user: user)
                }
//                self.db.collection("users").document(userId).updateData(["photo": downloadURL.absoluteString]) { error in
//                    if let error = error {
//                        print("Error updating profile image URL: \(error.localizedDescription)")
//                    } else {
//                        DispatchQueue.main.async {
//                            self.user?.photo = downloadURL.absoluteString
//                        }
//                    }
//                }
                
            }
        }
    }

    func uploadProfilePhoto(photo: UIImage, user: User) {
        guard let imageData = photo.jpegData(compressionQuality: 0.4) else {
            print("Failed to convert image to JPEG data")
            return }
        
        let uniqueId = UUID().uuidString
        let storageRef = Storage.storage().reference().child("photo").child("\(uniqueId).jpg")
        
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
                
                print("Download URL: \(downloadURL.absoluteString)")
                
                self.updatePhotoURL(photoURL: downloadURL.absoluteString, user: user)
            }
        }
        
    }

    
//    func imageCompression(image: UIImage) -> String? {
//        guard let imageData = image.jpegData(compressionQuality: 0.4) else {
//            print("Failed to convert image to JPEG data")
//            return nil }
//        let base64String = imageData.base64EncodedString()
//        return base64String
//    }
    
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
