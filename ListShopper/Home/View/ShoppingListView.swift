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
    
    @ObservedObject var listItemViewModel = ListItemViewModel()
    @FirestoreQuery var items: [ListItem]
    @State private var editPresented = false
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
                        .sheet(isPresented: $isSheetPresented) {
                            ListItemView(isSheetPresented: $isSheetPresented)
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
                ListItemView(isSheetPresented: $isSheetPresented)
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
        let db = Firestore.firestore()
        
        guard let userId = Auth.auth().currentUser?.uid else {
                 print(#function, "Could not get user ID")
                 return
             }
        
        db.collection("users")
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
    
    func editItem(_ item: ListItem) {
        isSheetPresented = true
        let viewModel = ListItemViewModel(listItem: item)
        viewModel.editListItem()
    }    
}

#Preview {
    ShoppingListView(userId: "nrHQT5nXSKUqRbtfZ0xbiJRlg1f2")
}
