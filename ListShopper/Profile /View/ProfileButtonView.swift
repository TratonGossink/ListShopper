//
//  ProfileButtonsView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/19/25.
//

import SwiftUI

struct ProfileButtonView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    @Binding var showAlert: Bool
    @State private var alertType: AlertType = .loggedOut
    @State private var isPressed: Bool = false
    
    enum AlertType {
        case  logoutConfirmation, loggedOut
    }
    
    var body: some View {
        
        CustomButton(title: "Log Out", backgroundColor: .blue, textColor: .black) {
            alertType = .logoutConfirmation
            showAlert = true
        }
        .alert(isPresented: $showAlert) {
            switch alertType {
            case .logoutConfirmation:
                return Alert(title: Text("Are you sure you \n want to log out?"), primaryButton: .destructive(Text("Log Out")){
                    profileViewModel.logOut()
                    showAlert = true
                    alertType = .loggedOut
                    
                },
                    secondaryButton: .cancel()
                )
            case .loggedOut:
                return Alert(title: Text("You have been logged out."),
                             dismissButton: .cancel(Text("OK")) {
                }
                )
            }
        }
    }
}

#Preview {
    ProfileButtonView(showAlert: .constant(false))
}
