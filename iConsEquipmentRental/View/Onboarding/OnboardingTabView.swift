//
//  OnboardingTabView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import SwiftUI

struct OnboardingTabView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                // Student Button
                Button(action: {
                    onboardingVM.studentOrIcon = 0
                }, label: {
                    VStack(alignment: .leading) {
                        Text("Student")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .opacity(onboardingVM.studentOrIcon == 1 ? 0.35 : 1)
                            .foregroundColor(.black)
                        
                        Capsule()
                            .frame(width: 40, height: 3, alignment: .leading)
                            .foregroundColor(Color("Green"))
                            .opacity(onboardingVM.studentOrIcon == 1 ? 0 : 1)
                    }
                })
                
                // iCon Button
                Button(action: {
                    onboardingVM.studentOrIcon = 1
                }, label: {
                    VStack(alignment: .trailing) {
                        Text("iCon")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .opacity(onboardingVM.studentOrIcon == 0 ? 0.35 : 1)
                        
                        Capsule()
                            .frame(width: 40, height: 3, alignment: .leading)
                            .foregroundColor(Color("Blue"))
                            .opacity(onboardingVM.studentOrIcon == 0 ? 0 : 1)
                    }
                    .offset(x: 50)
                })
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
