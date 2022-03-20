//
//  ProfileInfoView.swift
//  iCons
//
//  Created by William Little on 2022-02-24.
//

import SwiftUI

struct ProfileInfoView: View {
    
    @EnvironmentObject var rootVM: RootViewModel
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    var body: some View {
        ZStack {
            
            // RECTANGLE
            RoundedRectangle(cornerRadius: 15)
                .frame(width: UIScreen.main.bounds.maxX - 50, height: 200, alignment: .center)
                .foregroundColor(Color("ProfileGray"))
            
            ZStack {
                Circle()
                    .frame(width: 90, height: 90, alignment: .center)
                    .offset(y: -110)
                    .foregroundColor(onboardingVM.student ? Color("ProfileGreen") : Color("iConProfileColor"))
                
                
                // USERS INITIALS
                HStack {
                    if rootVM.singleInitital {
                        Text(rootVM.firstInitial)
                            .font(.title)
                            .foregroundColor(Color("ItemPreviewTitle"))
                            .fontWeight(.bold)
                            .offset(y: -20)
                    } else {
                        HStack {
                            Text(rootVM.firstInitial)
                                .font(.title)
                                .foregroundColor(Color("ItemPreviewTitle"))
                                .fontWeight(.bold)
                                .offset(x: 3)
                            
                            Text(rootVM.lastIntitial)
                                .font(.title)
                                .foregroundColor(Color("ItemPreviewTitle"))
                                .fontWeight(.bold)
                                .offset(x: -3)
                        }
                            .offset(y: -20)
                    }
                }
                .padding(.horizontal, 5)
                .offset(y: -90)
            }
            
            
            VStack(alignment: .leading) {
                
                // NAME AND EMAIL
                if onboardingVM.student {
                    Text(rootVM.fullName)
                        .foregroundColor(Color("ItemPreviewTitle"))
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                } else {
                    HStack {
                        Text(rootVM.iConFullName)
                            .foregroundColor(Color("ItemPreviewTitle"))
                            .fontWeight(.semibold)
                        Text("iCon")
                            .foregroundColor(Color("Blue"))
                            .fontWeight(.bold)
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color("Blue"))
                    }
                    .padding(.horizontal)
                }
               
                Text(onboardingVM.student ? rootVM.studentQueensEmail : rootVM.iConQueensEmail)
                    .foregroundColor(Color("TextGray"))
                    .padding(.horizontal)
                    .offset(y: -3)

                
                // ITEMS RENTED TOTAL
                HStack {
                    Text(onboardingVM.student ? String(rootVM.itemsRented) : String(rootVM.shiftHistory.count))
                        .foregroundColor(Color("ItemPreviewTitle"))
                        .fontWeight(.semibold)
                    Text(onboardingVM.student ? "Items Rented" : "Shifts Completed")
                        .foregroundColor(Color("TextGray"))
                        .offset(x: -4)
                }
                    .padding(.horizontal)
                    .offset(y: 15)

                
                // OWING TO ICONS TOTAL
                HStack {
                    Text(onboardingVM.student ? "$\(String(rootVM.owingToIcons))" : "0")
                        .foregroundColor(Color("ItemPreviewTitle"))
                        .fontWeight(.semibold)
                    Text(onboardingVM.student ? "Owing to iCons" : "Hours Total")
                        .foregroundColor(Color("TextGray"))
                        .offset(x: -4)
                }
                    .padding(.horizontal)
                    .offset(y: 15)
            }
                .offset(x: -60)
        }
    }
}
