//
//  UserInfoView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/19/25.
//

import SwiftUI

struct UserInfoView: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            userInfoRow(label: "Name:", value: user.name)
            userInfoRow(label: "Email:", value: user.email)
            userInfoRow(label: "Member Since:", value: (Date(timeIntervalSince1970: user.joined).formatted(date:.abbreviated, time: .shortened)))
        }
        .padding()
    }
    private func userInfoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .bold()
            Text(value)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    UserInfoView(user: User(
        id: "123",
        name: "John Doe",
        email: "john@example.com",
        joined: Date().timeIntervalSince1970,
        imageURL: nil
    ))
}
