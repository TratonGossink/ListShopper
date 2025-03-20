//
//  CustomTabBarView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/19/25.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @State private var userId: String = ""
    @StateObject var homeViewModel = HomeViewModel(userId: userId)
    
    var body: some View {
        
        if homeViewModel.isSignedIn, !homeViewModel.currentUserId.isEmpty{
                accountView
            } else {
                LogInView()
            }
        }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    CustomTabBarView()
}
