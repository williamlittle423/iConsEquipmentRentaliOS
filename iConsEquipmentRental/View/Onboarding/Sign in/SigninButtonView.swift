//
//  SigninButtonView.swift
//  iCons
//
//  Created by William Little on 2022-02-26.
//

import SwiftUI

struct SigninButtonView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    var body: some View {
        ZStack {
            Button(action: {
                if onboardingVM.studentOrIcon == 0 {
                    onboardingVM.studentSignin()
                } else {
                    onboardingVM.iConSignin()
                }
            }, label: {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: UIScreen.main.bounds.maxX - 75, height: 55)
                    .foregroundColor(onboardingVM.studentOrIcon == 0 ? Color("Green") : Color("Blue"))
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 3)
            })
                .alert("Access code is invalid", isPresented: $onboardingVM.displayAccessCodeAlert) {
                    Button("OK", role: .cancel) { }
                }
                .alert("Access code is already in use", isPresented: $onboardingVM.displayInUseAlert) {
                    Button("OK", role: .cancel) { }
                }
                .alert("Authentication Error", isPresented: $onboardingVM.displaySignupError) {
                    Button("OK", role: .cancel) { }
                }
            HStack {
                Text(onboardingVM.buttonText)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .offset(x: 15)
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
                    .frame(width: 18, height: 15)
                    .offset(x: 70)
            }
        }
    }
}

struct SigninButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SigninButtonView()
    }
}
