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
    @State private var animateCheckmark = false
    
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
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    listItemViewModel.toggleIsComplete(item: item)
                    animateCheckmark.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    animateCheckmark = false
                }
            } label: {
                Image(systemName: item.isComplete ? "checkmark.circle.fill" :"circle")
                    .scaleEffect(animateCheckmark ? 1.3 : 1.0)
            }
        }
    }
}

#Preview {
    ItemRowView(item: ListItem(id: "sampleId", title: "Sample Title", dueDate: Date().timeIntervalSinceReferenceDate, createdDate: Date().timeIntervalSinceReferenceDate, isComplete: false), listItemViewModel: ListItemViewModel())
}
