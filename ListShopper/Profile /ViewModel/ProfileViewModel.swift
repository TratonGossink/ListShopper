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
    @Published var user: User? = nil
    
    let db  = Firestore.firestore()
    let storage  = Storage.storage().reference()
    
    init() {
        fetchUser()
    }
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return
        }
        
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in guard let self = self, let snapshot = snapshot, error == nil
            else { return }
            
            if let user = try? snapshot.data(as: User.self) {
                DispatchQueue.main.async {
                    self.user = user
                }
            }
        }
    }
    
    func uploadProfileImage(image: UIImage) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        
        let profileRef = storage.child("profile_images/\(userId).jpg")
        
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
                
                self.db.collection("users").document(userId).updateData(["profileImageURL": downloadURL.absoluteString]) { error in
                    if let error = error {
                        print("Error updating profile image URL: \(error.localizedDescription)")
                    } else {
                        DispatchQueue.main.async {
                            self.user?.imageURL = downloadURL.absoluteString
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
}
