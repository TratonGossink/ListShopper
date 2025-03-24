//
//  ListItemView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/19/25.
//

import SwiftUI

struct ListItemView: View {
    
    @ObservedObject var listItemViewModel: ListItemViewModel
    @Environment(\.dismiss) var dismiss
    var listItem: ListItem
    @State var isEditingName: Bool = false
    
    init(listItem: ListItem) {
        self.listItem = listItem
        self._listItemViewModel = ObservedObject(initialValue: ListItemViewModel(listItem: listItem))
    }

    var body: some View {
        VStack {
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.top, 35)
            if listItem.id != UUID().uuidString {
                Text("New Item")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 40)
            } else {
                Text("Update Item")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 40)
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
                if listItemViewModel.canSave {
                    listItemViewModel.save()
                    dismiss()
                } else {
                    listItemViewModel.showAlert = true
                }
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
    let dueDate = Date().timeIntervalSince1970
    let title = "Test Item"
    let createdDate = Date().timeIntervalSinceReferenceDate
    let isComplete = false
    ListItemView(listItem: ListItem(title: title, dueDate: dueDate, createdDate: createdDate, isComplete: isComplete))
}
