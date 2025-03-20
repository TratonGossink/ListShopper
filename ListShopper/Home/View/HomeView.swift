//
//  HomeView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/18/25.
//

import SwiftUI
import FirebaseFirestore

struct HomeView: View {
    
    @FirestoreQuery var items: [ListItem]
    @StateObject private var homeViewModel = HomeViewModel(userId: <#String#>)
    
    var body: some View {
        NavigationStack {
            VStack {
                List(items) { item in
                    ListItemView(item: items)
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
