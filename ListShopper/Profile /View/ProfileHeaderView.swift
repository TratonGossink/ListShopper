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
    @State private var selectedImage: UIImage?
    @ObservedObject var profileViewModel: ProfileViewModel
   
    var body: some View {
        ZStack {
            if let profileURL = user.imageURL, let url = URL(string: profileURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 100)
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(style: StrokeStyle(lineWidth: 2)))
                    case .failure:
                        defaultProfileImage
                    @unknown default:
                        defaultProfileImage
                    }
                }
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
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .offset(x: 40, y: 40)
                }
            }
        }
        .frame(width: 100, height: 100)
        .onTapGesture {
            showImagePicker = true
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        .onChange(of: selectedImage) { image in
            if let image = image {
                profileViewModel.uploadProfileImage(image: image)
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
}

#Preview {
    ProfileHeaderView(user: User(
        id: "123",
        name: "John Doe",
        email: "john@example.com",
        joined: Date().timeIntervalSince1970,
        imageURL: "https://example.com/profile.jpg"
    ), showImagePicker: .constant(false),
                      profileViewModel: ProfileViewModel())
}
