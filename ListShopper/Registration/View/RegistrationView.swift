//
//  RegistrationView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/17/25.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject var registrationViewModel = RegistrationViewModel()
    @State private var isRegistrationSuccessful: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomHeader(title: "Register",
                             subtitle: "Start Here",
                             angle: -15,
                             background: .blue)
                Form {
                    if !registrationViewModel.errorMessage.isEmpty {
                        Text(registrationViewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    TextField("Username", text: $registrationViewModel.name)
                        .autocorrectionDisabled(true)
                        .keyboardType(.asciiCapable)
                    
                    TextField("Email Address", text: $registrationViewModel.email)
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $registrationViewModel.password)
                        .autocorrectionDisabled(true)
                        .keyboardType(.asciiCapable)
                    
                    SecureField("Confirm Password", text: $registrationViewModel.confirmPassword)
                        .autocorrectionDisabled(true)
                        .keyboardType(.asciiCapable)
                }
                .scrollContentBackground(.hidden)
                
                CustomButton(
                    title: "Create Account",
                    backgroundColor: .green,
                    textColor: .white) {
                        registrationViewModel.register()
                    }
                    .padding()
            }
            .offset(y: -100)
        }
    }
}

#Preview {
    RegistrationView()
}
