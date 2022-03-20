//
//  iConProfileView.swift
//  iCons
//
//  Created by William Little on 2022-03-01.
//

import SwiftUI

struct iConProfileView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var iConVM: iConViewModel
    
    var body: some View {
        ZStack {
            
            
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
                            Text("Recent Shifts")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .opacity(profileVM.selectedTab == 1 ? 0.35 : 1)
                                .foregroundColor(.black)
                            
                            Capsule()
                                .frame(width: 60, height: 3, alignment: .leading)
                                .foregroundColor(Color("Blue"))
                                .opacity(profileVM.selectedTab == 1 ? 0 : 1)
                        }
                    })
                    
                    Button(action: {
                        profileVM.selectedTab = 1
                    }, label: {
                        VStack(alignment: .trailing) {
                            Text("Items Prepared")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .opacity(profileVM.selectedTab == 0 ? 0.35 : 1)
                            
                            Capsule()
                                .frame(width: 60, height: 3, alignment: .leading)
                                .foregroundColor(Color("Blue"))
                                .opacity(profileVM.selectedTab == 0 ? 0 : 1)
                        }
                        .offset(x: 50)
                    })
                    Spacer()
                }
                .offset(y: 20)
                .padding()
                
                if profileVM.selectedTab == 0 {
                    if iConVM.onDuty {
                        Button(action: {
                            iConVM.endShift()
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 35)
                                    .frame(width: 200, height: 60)
                                    .foregroundColor(Color("Blue"))
                                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 1, y: 3)
                                Text("End Shift")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                            .padding(.vertical, 50)
                        })
                    } else {
                        Text("No shifts yet")
                            .padding()
                    }
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

struct iConProfileView_Previews: PreviewProvider {
    static var previews: some View {
        iConProfileView()
    }
}
