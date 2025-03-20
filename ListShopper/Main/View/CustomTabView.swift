////
////  MainView_2.swift
////  ListShopper
////
////  Created by Traton Gossink on 3/17/25.
////
//
//import SwiftUI
//
//struct CustomTabView: View {
//   
//    @State var selectedTab = 0
//    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//                    TabView(selection: $selectedTab) {
//                        HomeView()
//                            .tag(0)
//
//                        Search()
//                            .tag(1)
//
//                        Tickets()
//                            .tag(2)
//
//                        Profile()
//                            .tag(3)
//
//                        Settings()
//                            .tag(4)
//                    }
//
//                    RoundedRectangle(cornerRadius: 25)
//                        .frame(width: 350, height: 70)
//                        .foregroundColor(.white)
//                        .shadow(radius: 0.8)
//
//                    Button {
//                        selectedTab = 2
//                    } label: {
//                        CustomTabItem(imageName: "ticket", title: "Ticket", isActive: (selectedTab == 2))
//                    }
//                    .frame(width: 65, height: 65)
//                    .background(Color.white)
//                    .clipShape(Circle())
//                    .shadow(radius: 0.8)
//                    .offset(y: -50)
//
//                    HStack {
//                        ForEach(TabbedItems.allCases, id: \.self) { item in
//                            if item != .ticket { // Exclude the center button
//                                Button {
//                                    selectedTab = item.rawValue
//                                } label: {
//                                    CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
//                                }
//                            }
//                        }
//                    }
//                    .frame(height: 70)
//                }
//            }
//    
//}
//
//#Preview {
//    CustomTabView()
//}
