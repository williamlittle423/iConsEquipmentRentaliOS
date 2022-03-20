//
//  SigninView.swift
//  iCons
//
//  Created by William Little on 2022-02-26.
//

import SwiftUI

struct SigninView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.onboardingVM.displaySignin = false
                }, label: {
                    Image("backArrow")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fit)
                })
                Spacer()
            }
            .padding()
            OnboardingProgressView()
                .padding()
            Text("Sign in with your @queensu.ca email \nas a Student or iCon")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding()
            OnboardingTabView()
                .padding()
            
            if onboardingVM.onboardingView == 1 && onboardingVM.studentOrIcon == 0 {
                StudentSigninTextFieldsView()
                    .padding()
            }
            if onboardingVM.onboardingView == 1 && onboardingVM.studentOrIcon == 1 {
                iConSigninTextFieldsView()
                    .padding()
            }
            
            Spacer()
            
            SigninButtonView()
                .padding()
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
