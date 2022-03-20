//
//  ContentView.swift
//  iCons
//
//  Created by William Little on 2022-02-16.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    @State private var progressValue: CGFloat = 0.5
    
    var body: some View {
        
        // ONBOARDING VIEW
        if onboardingVM.displaySignin {
            SigninView()
        } else {
            VStack(alignment: .center) {
                
                Spacer()
                
                // Logo and Progress Circle
                OnboardingProgressView()
                    .offset(y: onboardingVM.onboardingView == 0 ? -15 : -20)
                    .animation(.easeOut)
                    
                
                // Welcome Line 1
                TitleView()
                    .offset(y: onboardingVM.onboardingView == 0 ? 50 : -500)
                
                Text("Sign up with your @queensu.ca email \nas a Student or iCon")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .offset(y: onboardingVM.onboardingView == 0 ? -500 : -80)
                
                
                // STUDENT AND ICON TAB VIEW
                
                OnboardingTabView()
                    .offset(y: onboardingVM.onboardingView == 0 ? -700 : -35)
                    .padding(.horizontal)
                
                if onboardingVM.onboardingView == 1 && onboardingVM.studentOrIcon == 0 {
                    StudentTextFieldsView()
                }
                if onboardingVM.onboardingView == 1 && onboardingVM.studentOrIcon == 1 {
                    iConTextFieldsView()
                }

                
                
                Spacer()
                
                if onboardingVM.onboardingView == 0 {
                    FirstButtonView()
                } else {
                    SecondButtonView()
                }

                if onboardingVM.onboardingView == 1 {
                    HStack {
                        Text("Already have an account?")
                            .font(.custom("Helvetica Neue", size: 15))
                            .foregroundColor(Color("ButtonGray"))
                        Button(action: {
                            onboardingVM.displaySignin = true
                        }, label: {
                            Text("Sign in")
                                .font(.custom("Helvetica Neue", size: 15))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("SigninGray"))
                        })
                    }
                    .padding(8)
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}






