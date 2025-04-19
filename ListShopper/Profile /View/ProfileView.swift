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
    @State private var alertType: AlertType = .none
    
    enum AlertType {
        case none, logoutConfirmation, loggedOut
        case logout
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if let userInfo = profileViewModel.user {
                    ProfileHeaderView(user: userInfo, showImagePicker: $showImagePicker, profileViewModel: profileViewModel)
                    UserInfoView(user: userInfo)
                    Spacer()
                    ProfileButtonView(showAlert: $showAlert)
                    Spacer()
                } else {
                    Text("Profile Loading...")
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            profileViewModel.fetchUser()
        }

        .alert("You have been logged out.", isPresented: $isLoggedOut) {
            Button("OK", role: .cancel) {}
        }
    }
}

#Preview {
    ProfileView()
}
