//
//  SecondButtonView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import SwiftUI

struct SecondButtonView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    @EnvironmentObject var rootVM: RootViewModel
    
    var body: some View {
        ZStack {
            Button(action: {
                if onboardingVM.studentOrIcon == 0 {
                    onboardingVM.studentSignup()
                } else {
                    onboardingVM.iConSignup()
                }
            }, label: {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: UIScreen.main.bounds.maxX - 75, height: 55)
                    .foregroundColor(onboardingVM.studentOrIcon == 0 ? Color("Green") : Color("Blue"))
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 3)
            })
                .alert("A @queensu.ca email is required to sign up", isPresented: $onboardingVM.displayEmailAlert) {
                    Button("OK", role: .cancel) { }
                }
                .alert("Passwords do not match", isPresented: $onboardingVM.displayPasswordAlert) {
                    Button("OK", role: .cancel) { }
                }
                .alert("Missing sign up information", isPresented: $onboardingVM.displaySignupAlert) {
                    Button("OK", role: .cancel) { }
                }
                .alert("Access code is invalid", isPresented: $onboardingVM.displayAccessCodeAlert) {
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
