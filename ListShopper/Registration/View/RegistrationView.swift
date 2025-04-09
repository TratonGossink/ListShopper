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
                        .onChange(of: registrationViewModel.name) { _ in
                            registrationViewModel.clearErrorMessage()
                        }
                    
                    TextField("Email Address", text: $registrationViewModel.email)
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .onChange(of: registrationViewModel.email) { _ in
                            registrationViewModel.clearErrorMessage()
                        }
                    
                    SecureField("Password", text: $registrationViewModel.password)
                        .autocorrectionDisabled(true)
                        .keyboardType(.asciiCapable)
                    
                    SecureField("Confirm Password", text: $registrationViewModel.confirmPassword)
                        .autocorrectionDisabled(true)
                        .keyboardType(.asciiCapable)
                }
                .scrollContentBackground(.hidden)
                NavigationLink(destination: MainView(), isActive: $isRegistrationSuccessful){
                    EmptyView()
                }
                CustomButton(
                    title: "Create Account",
                    backgroundColor: .green,
                    textColor: .white) {
                        registrationViewModel.register()
//                        if !registrationViewModel.isRegistering {
//                            registrationViewModel.register() { success in
//                                if success {
//                                    isRegistrationSuccessful = true
//                                } else {
//                                    isRegistrationSuccessful = false
//                                }
//                            }
//                        }
                    }
                    .padding()
            }
            .offset(y: -100)
//            .background(
//                NavigationLink("", destination: MainView())
//                    .opacity(isRegistrationSuccessful ? 1 : 0)
//            )
        }
    }
}

#Preview {
    RegistrationView()
}
