//
//  HomeView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/18/25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ShoppingListView: View {
    
    @FirestoreQuery var items: [ListItem]
    @State private var isSheetPresented = false
    @State private var selectedItem: ListItem? = nil
    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/listItems")
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(items) { item in
                    ItemRowView(item: item)
                        .swipeActions {
                            Button("Delete") {
                                deleteItem(item)
                            }
                            .tint(.red)
                            Button("Edit") {
                                selectedItem = item
                                isSheetPresented = true
                            }
                            .tint(.gray)
                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle(Text("Shopping List"))
            .toolbar {
                Button {
                    selectedItem = nil
                    isSheetPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                ListItemView(selectedItem: selectedItem, isEditing: selectedItem != nil)
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
        guard let userId = Auth.auth().currentUser?.uid else {
            print(#function, "Could not get user ID")
            return }
        Firestore.firestore()
        .collection("users")
            .document(userId)
            .collection("listItems")
            .document(item.id)
            .delete() {
                error in
                if let error = error {
                    print("Error deleting document: \(error.localizedDescription)")
                } else {
                    print("Item successfully deleted")
                }
            }
    }
}

#Preview {
    ShoppingListView(userId: "nrHQT5nXSKUqRbtfZ0xbiJRlg1f2")
}
