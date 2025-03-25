//
//  HomeView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/18/25.
//

import SwiftUI
import FirebaseFirestore

struct HomeView: View {
    
    @FirestoreQuery(collectionPath: "listItems") var items: [ListItem]
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var listItemViewModel = ListItemViewModel()
    @State private var editPresented = false
    @State private var selectedItem: ListItem?
    
    init(userId: String? = nil) {
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(userId: userId!))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(items) { item in
                        ListItemView(listItem: item)
                            .swipeActions {
                                Button("Delete") {
                                    homeViewModel.deleteItem(id: item.id)
                                }
                                .tint(.red)
                                Button("Edit") {
                                    selectedItem = item
                                    editPresented = true
                                }
                                .tint(.gray)
                            }
                            .sheet(isPresented: $editPresented) {
                                //                            EditItemView(editItemPresented: true, listItem: $selectedItem)
                                if let itemToEdit = selectedItem {
                                    EditItemView(item: itemToEdit)
                                }
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
