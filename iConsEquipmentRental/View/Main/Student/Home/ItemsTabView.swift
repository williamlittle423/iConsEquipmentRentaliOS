//
//  ItemsTabView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import SwiftUI


struct ItemsTabView: View {
    
    @EnvironmentObject var studentHomeVM: StudentHomeViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                
                Button(action: {
                    self.studentHomeVM.selectedTab = "All"
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 90, height: 30)
                            .foregroundColor(studentHomeVM.selectedTab == "All" ? Color("SelectedTab") : Color("NonSelectedTab"))
                        Text("All")
                            .foregroundColor(studentHomeVM.selectedTab == "All" ? .white : Color("NonSelectedTabText"))
                            .font(.caption)
                    }
                })
                
                Button(action: {
                    self.studentHomeVM.selectedTab = "Chargers"
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 90, height: 30)
                            .foregroundColor(studentHomeVM.selectedTab == "Chargers" ? Color("SelectedTab") : Color("NonSelectedTab"))
                        Text("Chargers")
                            .foregroundColor(studentHomeVM.selectedTab == "Chargers" ? .white : Color("NonSelectedTabText"))
                            .font(.caption)
                    }
                })
                
                Button(action: {
                    studentHomeVM.selectedTab = "Stationary"
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 90, height: 30)
                            .foregroundColor(studentHomeVM.selectedTab == "Stationary" ? Color("SelectedTab") : Color("NonSelectedTab"))
                        Text("Stationary")
                            .foregroundColor(studentHomeVM.selectedTab == "Stationary" ? .white : Color("NonSelectedTabText"))
                            .font(.caption)
                    }
                })
                
                Button(action: {
                    self.studentHomeVM.selectedTab = "Textbooks"
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 90, height: 30)
                            .foregroundColor(studentHomeVM.selectedTab == "Textbooks" ? Color("SelectedTab") : Color("NonSelectedTab"))
                        Text("Textbooks")
                            .foregroundColor(studentHomeVM.selectedTab == "Textbooks" ? .white : Color("NonSelectedTabText"))
                            .font(.caption)
                    }
                })
                
                Button(action: {
                    self.studentHomeVM.selectedTab = "Computer Accessories"
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 160, height: 30)
                            .foregroundColor(studentHomeVM.selectedTab == "Computer Accessories" ? Color("SelectedTab") : Color("NonSelectedTab"))
                        Text("Computer Accessories")
                            .foregroundColor(studentHomeVM.selectedTab == "Computer Accessories" ? .white : Color("NonSelectedTabText"))
                            .font(.caption)
                    }
                })
            }
            .padding(.horizontal)
        })
    }
}
