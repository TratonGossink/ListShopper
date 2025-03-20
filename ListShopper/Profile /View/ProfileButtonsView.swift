//
//  ProfileButtonsView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/19/25.
//

import SwiftUI

struct ProfileButtonsView: View {
    
    @Binding var showAlert: Bool
    
    var body: some View {
        
        CustomButton(title: "Log Out", backgroundColor: .blue, textColor: .black) {
            showAlert = true
        } 
    }
}

#Preview {
    ProfileButtonsView(showAlert: .constant(false))
}
