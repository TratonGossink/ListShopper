//
//  ProfileView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/18/25.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    @State private var showAlert: Bool = false
    @State private var isLoggedOut: Bool = false
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if let user = profileViewModel.user {
                    ProfileHeaderView(user: user, showImagePicker: $showImagePicker, profileViewModel: ProfileViewModel())
                    UserInfoView(user: user)
                    Spacer()
                    ProfileButtonsView(showAlert: $showAlert)
                } else {
                    Text("Profile Loading...")
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            profileViewModel.fetchUser()
        }
        .alert("Are you sure you \n want to log out?", isPresented: $showAlert) {
            Button("Log Out", role: .destructive) {
                profileViewModel.logOut()
            }
            Button("Cancel", role: .cancel) {}
        }
        .alert("You have been logged out.", isPresented: $isLoggedOut) {
            Button("OK", role: .cancel) {}
        }
    }
}

#Preview {
    ProfileView()
}
