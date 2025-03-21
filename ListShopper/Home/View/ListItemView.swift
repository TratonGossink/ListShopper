//
//  ListItemView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/19/25.
//

import SwiftUI

struct ListItemView: View {
    
    @ObservedObject var viewModel: ListItemViewModel
    @Environment(\.dismiss) var dismiss
    @State var listItem: ListItem
    @State var isEditingName: Bool = false
    
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
                TextField("Title", text: $viewModel.title)
                
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
            .scrollContentBackground(.hidden)
            .border(Color.gray.opacity(0.5), width: 1)
            .cornerRadius(8)
            .padding()
            CustomButton(title: "Save", backgroundColor: .blue, textColor: .white) {
                if viewModel.canSave {
                    viewModel.save()
                    dismiss()
                } else {
                    viewModel.showAlert = true
                }
            }
            .padding(.bottom, 35)
        }
        .alert(isPresented: $viewModel.showAlert) {
            .init(title: Text("Error"),
                  message: Text("Please enter a title and due date."))
        }
        
        
    }
}

#Preview {
    ListItemView()
}
