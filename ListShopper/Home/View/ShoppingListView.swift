//
//  HomeView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/18/25.
//

import SwiftUI
import FirebaseFirestore

struct ShoppingListView: View {
    
    @FirestoreQuery var items: [ListItem]
    @StateObject private var shoppingListViewModel = ShoppingListViewModel()
    @StateObject var listItemViewModel = ListItemViewModel()
    @State private var editPresented = false
    @State private var selectedItem: ListItem?
    @State private var showAddItemView: Bool = false
    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/listItems")
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(items) { item in
                        ListItemView(listItem: item)
                            .swipeActions {
                                Button("Delete") {
                                    deleteItem(item)
                                }
                                .tint(.red)
                                Button("Edit") {
                                    selectedItem = item
                                    editPresented = true
                                }
                                .tint(.gray)
                            }
                            .sheet(isPresented: $editPresented) {
                                if let itemToEdit = selectedItem {
                                }
                            }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Your List")
            .toolbar {
                Button {
                    showAddItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddItemView) {
                ListItemView(listItem: selectedItem!)
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            deleteItem(item)
        }
    }
    
    func deleteItem(_ item: ListItem) {
        let viewModel = ListItemViewModel(listItem: item)
        viewModel.deleteItem()
    }
}

#Preview {
    ShoppingListView(userId: "sampleId")
}
