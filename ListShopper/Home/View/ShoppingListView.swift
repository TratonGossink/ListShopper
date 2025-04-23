//
//  HomeView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/18/25.
//

import SwiftUI
import FirebaseFirestore

struct ShoppingListView: View {
    
    @ObservedObject var listItemViewModel = ListItemViewModel()
    @FirestoreQuery var items: [ListItem]
    @State private var editPresented = false
    
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
                                editItem(item)
                            }
                            .tint(.gray)
                        }
                        .sheet(isPresented: $listItemViewModel.isSheetPresented) {
                            ListItemView(isSheetPresented: $listItemViewModel.isSheetPresented)
//                            listItemViewModel.editListItem
//                            }
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
        viewModel.deleteListItem()
    }
    
//    func editItem(_ item: ListItem) {
//        //        let viewModel = ListItemViewModel(listItem: item)
//        //        viewModel.isSheetPresented = true
//        listItemViewModel.title = item.title
//           listItemViewModel.dueDate = Date(timeIntervalSince1970: item.dueDate)
//           listItemViewModel.itemId = UUID(uuidString: item.id)
////        let editSheet = ListItemView(isSheetPresented: $editPresented)
////        editSheet.isSheetPresented = true
//        editPresented = true
//    }
    func editItem(_ item: ListItem) {
        listItemViewModel.isSheetPresented = true
        let viewModel = ListItemViewModel(listItem: item)
        viewModel.editListItem()
    }
    
}


#Preview {
    ShoppingListView(userId: "nrHQT5nXSKUqRbtfZ0xbiJRlg1f2")
}
