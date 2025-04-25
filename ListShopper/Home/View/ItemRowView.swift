//
//  ItemRowView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/31/25.
//

import SwiftUI
import FirebaseFirestore

struct ItemRowView: View {
    
    var item: ListItem 
    @State private var showSheet: Bool = false
    @ObservedObject var listItemViewModel = ListItemViewModel()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .bold()
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            
            Button {
                listItemViewModel.toggleIsComplete(item: item)
            } label: {
                Image(systemName: item.isComplete ? "checkmark.circle.fill" :"circle")
            }
        }
    }
}

#Preview {
    ItemRowView(item: ListItem(id: "sampleId", title: "Sample Title", dueDate: Date().timeIntervalSinceReferenceDate, createdDate: Date().timeIntervalSinceReferenceDate, isComplete: false), listItemViewModel: ListItemViewModel())
}
