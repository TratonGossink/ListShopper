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
    @State private var showToast = false
    @State private var toastMessage = ""
    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/listItems")
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List(items) { item in
                        ItemRowView(item: item)
                            .swipeActions {
                                Button("Delete") {
                                    withAnimation {
                                        deleteItem(item)
                                    }
                                }
                                .tint(.red)
                                Button("Edit") {
                                    selectedItem = item
//                                    isSheetPresented = true
                                }
                                .tint(.gray)
                            }
                    }
                    .listStyle(PlainListStyle())
                    .animation(.default, value: items)
                }
                if showToast {
                    VStack {
                        Spacer()
                        ToastView(message: toastMessage)
                            .transition(.move(edge: .bottom))
                            .padding(.bottom, 100)
                    }
                    .zIndex(1)
                }
            }
            .navigationTitle(Text("Shopping List"))
            .toolbar {
                Button {
                    selectedItem = ListItem(
                        id: UUID().uuidString,
                        title: "",
                        dueDate: Date().timeIntervalSince1970,
                        createdDate: Date().timeIntervalSince1970,
                        isComplete: false)
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(item: $selectedItem) { item in
                ListItemView(selectedItem: item)
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
                    showToast(message: "Item deleted")
                }
            }
    }
    
    func showToast(message: String) {
        toastMessage = message
        withAnimation {
            showToast = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showToast = false
            }
        }
    }
}

#Preview {
    ShoppingListView(userId: "nrHQT5nXSKUqRbtfZ0xbiJRlg1f2")
}
