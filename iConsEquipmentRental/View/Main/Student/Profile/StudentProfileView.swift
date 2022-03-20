//
//  StudentProfileView.swift
//  iCons
//
//  Created by William Little on 2022-02-24.
//

import SwiftUI

struct StudentProfileView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    @EnvironmentObject var rootVM: RootViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        ZStack() {
            VStack {
                HStack {
                    LogoView()
                    Spacer()
                    Button("Sign out") {
                        onboardingVM.signout()
                    }
                }
                .padding()
                
                // USER INFORMATION + RECTANGLE
                ProfileInfoView()
                    .offset(y: 20)
                
                // TAB VIEW
                HStack {
                    
                    // Student Button
                    Button(action: {
                        profileVM.selectedTab = 0
                    }, label: {
                        VStack(alignment: .leading) {
                            Text("Recents")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .opacity(profileVM.selectedTab == 1 ? 0.35 : 1)
                                .foregroundColor(.black)
                            
                            Capsule()
                                .frame(width: 60, height: 3, alignment: .leading)
                                .foregroundColor(Color("Green"))
                                .opacity(profileVM.selectedTab == 1 ? 0 : 1)
                        }
                    })
                    
                    // iCon Button
                    Button(action: {
                        profileVM.selectedTab = 1
                    }, label: {
                        VStack(alignment: .trailing) {
                            Text("Outstanding Items")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .opacity(profileVM.selectedTab == 0 ? 0.35 : 1)
                            
                            Capsule()
                                .frame(width: 60, height: 3, alignment: .leading)
                                .foregroundColor(Color("Green"))
                                .opacity(profileVM.selectedTab == 0 ? 0 : 1)
                        }
                        .offset(x: 50)
                    })
                    Spacer()
                }
                .offset(y: 20)
                .padding()
                
                if profileVM.selectedTab == 0 {
                    StudentRecentsView()
                        .padding()
                } else {
                    Text("No outstanding items")
                        .padding()
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct StudentProfileView_Previews: PreviewProvider {
    static var previews: some View {
        StudentProfileView()
    }
}

