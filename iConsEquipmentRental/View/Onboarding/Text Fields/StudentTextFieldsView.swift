//
//  OnboardingTextFieldsView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import SwiftUI

struct StudentTextFieldsView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            
            ZStack {
                TextField("Full Name", text: $onboardingVM.fullName)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("ButtonGray"), lineWidth: 2)
                            .frame(width: UIScreen.main.bounds.maxX - 50, height: 60, alignment: .center)
                    )
            }
            .padding(.horizontal, 50)
            
            ZStack {
                TextField("Queen's Email", text: $onboardingVM.studentQueensEmail)
                    .autocapitalization(.none)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("ButtonGray"), lineWidth: 2)
                            .frame(width: UIScreen.main.bounds.maxX - 50, height: 60, alignment: .center)
                    )
            }
            .padding(.horizontal, 50)
            
            ZStack {
                SecureField("Password", text: $onboardingVM.password)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("ButtonGray"), lineWidth: 2)
                            .frame(width: UIScreen.main.bounds.maxX - 50, height: 60, alignment: .center)
                    )
            }
            .padding(.horizontal, 50)
            
            ZStack {
                SecureField("Re-Enter Password", text: $onboardingVM.passwordReEnter)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("ButtonGray"), lineWidth: 2)
                            .frame(width: UIScreen.main.bounds.maxX - 50, height: 60, alignment: .center)
                    )
            }
            .padding(.horizontal, 50)
        }
    }
}
