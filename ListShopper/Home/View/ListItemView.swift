//
//  ListItemView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/19/25.
//

import SwiftUI
import FirebaseFirestore

struct ListItemView: View {
    
    @StateObject var listItemViewModel: ListItemViewModel
    @Environment(\.dismiss) var dismiss
    var selectedItem: ListItem?
    
    init(selectedItem: ListItem? = nil, isEditing: Bool = false) {
        _listItemViewModel = StateObject(wrappedValue: ListItemViewModel(listItem: selectedItem))
    }
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top, 25)
            if listItemViewModel.isEditing {
                Text("Update Item")
                    .font(.system(size: 32, weight: .bold))
            } else {
                Text("New Item")
                    .font(.system(size: 32, weight: .bold))
            }
            
            Form {
                TextField("Title", text: $listItemViewModel.title)
                
                DatePicker("Due Date", selection: $listItemViewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
            .scrollContentBackground(.hidden)
            .border(Color.gray.opacity(0.5), width: 1)
            .cornerRadius(8)
            .padding()
            
            CustomButton(title: "Save", backgroundColor: .blue, textColor: .white) {
                listItemViewModel.saveOrUpdate()
                dismiss()
            }
            .padding(.bottom, 35)
        }
        .onAppear {
            if let selectedItem = selectedItem {
                listItemViewModel.updateFromListItem(selectedItem)
            }
        }
        .alert(isPresented: $listItemViewModel.showAlert) {
            .init(title: Text("Error"),
                  message: Text("Please enter a title and due date."))
        }
    }
}

#Preview {
    ListItemView()
}
