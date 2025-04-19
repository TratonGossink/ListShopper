//
//  LogInView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/17/25.
//

import SwiftUI

struct LogInView: View {
    
    @StateObject var logInViewModel = LogInViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                CustomHeader(title: "List Shopper",
                             subtitle: "Make Shopping Easy",
                             angle: 15,
                             background: .orange)
                Form {
                    if !logInViewModel.errorMessage.isEmpty {
                        Text(logInViewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    TextField("Email Address",
                              text: $logInViewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocorrectionDisabled(true)
                    
                    SecureField("Password",
                                text: $logInViewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled(true)
                    .keyboardType(.asciiCapable)
                }
                .scrollContentBackground(.hidden)
                CustomButton(title: "Log In",
                             backgroundColor: .blue,
                             textColor: .white) {
                    logInViewModel.logIn()
                }
                             .padding()
                ///Account creation
                VStack {
                    Text("New Here?")
                    NavigationLink(destination: RegistrationView()) {
                        Text("Create an Account")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .bold()
                    }
                }
                .padding(.bottom, 70)
            }
        }
        Spacer()
    }
}

#Preview {
    LogInView()
}
