//
//  RegistrationView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/17/25.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var registerViewModel = RegistrationViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                CustomHeader(title: "Register",
                           subtitle: "Start Here",
                           angle: -15,
                           background: .blue)
                Form {
                    TextField("Username", text: $registerViewModel.name)
                        .autocorrectionDisabled()
                        .keyboardType(.asciiCapable)
                    
                    TextField("Email Address", text: $registerViewModel.email)
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $registerViewModel.password)
                        .autocorrectionDisabled(true)
                        .keyboardType(.asciiCapable)
                    
                    SecureField("Confirm Password", text: $registerViewModel.confirmPassword)
                        .autocorrectionDisabled(true)
                        .keyboardType(.asciiCapable)
                }
                .scrollContentBackground(.hidden)
                CustomButton(
                        title: "Create Account",
                        backgroundColor: .green,
                        textColor: .white) {
                            registerViewModel.register()
                }
            }
            .offset(y: -100)
        }
        
    }
}

#Preview {
    RegistrationView()
}
