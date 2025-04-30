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

    let onSave: () -> Void
    
    init(selectedItem: ListItem, onSave: @escaping () -> Void = {}) {
        _listItemViewModel = StateObject(wrappedValue: ListItemViewModel(listItem: selectedItem))
        self.onSave = onSave
    }
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top, 25)
            Text(listItemViewModel.isEditing ? "Update Item" : "New Item")
                .font(.system(size: 32, weight: .bold))
                
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
                onSave()
                dismiss()
            }
            .padding(.bottom, 35)
        }
        .alert(isPresented: $listItemViewModel.showAlert) {
            .init(title: Text("Error"),
                  message: Text("Please enter a title and due date."))
        }
    }
}

#Preview {
    ListItemView(selectedItem: ListItem(
        id: UUID().uuidString,
        title: "",
        dueDate: Date().timeIntervalSince1970,
        createdDate: Date().timeIntervalSince1970,
        isComplete: false
    ))}
