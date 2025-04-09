//
//  ProfileHeaderView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/19/25.
//

import SwiftUI
import PhotosUI

struct ProfileHeaderView: View {
    
    @State var user: User
    @Binding var showImagePicker: Bool
    @State var isSourceMenuShowing = false
    @State private var selectedImage: UIImage?
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    @ObservedObject var profileViewModel: ProfileViewModel
    private static var imageCache: [String: Image] = [:]
   
    var body: some View {
        ZStack {
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(style: StrokeStyle(lineWidth: 2)))
            } else {
                defaultProfileImage
            }
            ///Clickable Camera Icon
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { showImagePicker = true }) {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .offset(x: 30, y: 30)
                }
            }
        }
        .frame(width: 100, height: 100)
//        .onTapGesture {
//            showImagePicker = true
//        }
        .confirmationDialog("From where?", isPresented: $isSourceMenuShowing) {
            Button {
                // Set source to photo library
                self.source = .photoLibrary
                showImagePicker = true
            } label: {
                Text("Photo Library")
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                Button {
                    //Set source to camera
                    self.source = .camera
                    showImagePicker = true
                } label: {
                    Text("Take Photo")
                }
            }
        }
        
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: $selectedImage)
//        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        .onChange(of: selectedImage) { image in
            if let image = image {
                profileViewModel.uploadProfileImage(photo: image)
            }
        }
    }
    private var defaultProfileImage: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(style: StrokeStyle(lineWidth: 2)))
            .foregroundColor(.gray)
    }
    
    static func setImageCache(image: Image, forKey: String) {
        imageCache[forKey] = image
    }
}

#Preview {
    ProfileHeaderView(user: User(
        id: "123",
        name: "John Doe",
        email: "john@example.com",
        joined: Date().timeIntervalSince1970,
        photo: "https://example.com/profile.jpg"
    ), showImagePicker: .constant(false),
                      profileViewModel: ProfileViewModel())
}
