//
//  SettingsView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/18/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @State private var showAlert: Bool = false
    @State private var isLoggedOut: Bool = false
    @State private var isLoggedIn: Bool = true
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Dark Mode", isOn: $settingsViewModel.isDarkMode)
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
