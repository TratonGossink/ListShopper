//
//  HomeView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/18/25.
//

import SwiftUI
import FirebaseFirestore

struct ShoppingListView: View {
    
    
    //    @ObservedObject var listItemViewModel = ListItemViewModel()
    @ObservedObject var listItemViewModel = ListItemViewModel()
    @FirestoreQuery var items: [ListItem]
    @State private var editPresented = false
    //    private let userId: String
    
    init(itemId: String) {
        //        self.userId = userId
        self._items = FirestoreQuery(collectionPath: "itemList/\(itemId)/listItems")
//    self._listItemViewModel = StateObject(wrappedValue: ListItemViewModel(userId: userId))
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
                                editItem(item)
                            }
                            .tint(.gray)
                        }
                        .sheet(isPresented: $editPresented) {
                            ListItemView(isSheetPresented: $listItemViewModel.isSheetPresented)
                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle(Text("Shopping List"))
            .toolbar {
                Button {
                    listItemViewModel.isSheetPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $listItemViewModel.isSheetPresented) {
                ListItemView(isSheetPresented: $listItemViewModel.isSheetPresented)
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
    
    func editItem(_ item: ListItem) {
        //        let viewModel = ListItemViewModel(listItem: item)
        //        viewModel.isSheetPresented = true
        let editSheet = ListItemView(isSheetPresented: $editPresented)
        editSheet.isSheetPresented = true
    }
}


#Preview {
    ShoppingListView(itemId: "nrHQT5nXSKUqRbtfZ0xbiJRlg1f2")
}
