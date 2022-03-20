//
//  BottomTabView.swift
//  iCons
//
//  Created by William Little on 2022-02-24.
//

import SwiftUI

struct BottomTabView: View {
    
    @EnvironmentObject var rootVM: RootViewModel
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    var body: some View {
        HStack {
            
            // HOUSE TAB
            Button(action: {
                rootVM.selectedTab = 0
            }, label: {
                Image(systemName: onboardingVM.student ? "house.fill" : "tray.full")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(rootVM.selectedTab == 0 ? (onboardingVM.student ? Color("Green") : Color("Blue")) : Color("TextGray"))
            })
            
            // SEARCH TAB
            Button(action: {
                rootVM.selectedTab = 1
            }, label: {
                Image(systemName: onboardingVM.student ? "magnifyingglass" : "plus")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(rootVM.selectedTab == 1 ? (onboardingVM.student ? Color("Green") : Color("Blue")) : Color("TextGray"))
            })
            
            // PROFILE TAB
            Button(action: {
                rootVM.selectedTab = 2
            }, label: {
                Image(systemName: "person.fill")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(rootVM.selectedTab == 2 ? (onboardingVM.student ? Color("Green") : Color("Blue")) : Color("TextGray"))
            })
        }
        .padding()
        .background(.white)
        .clipShape(Capsule())
        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
        .padding()
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}
