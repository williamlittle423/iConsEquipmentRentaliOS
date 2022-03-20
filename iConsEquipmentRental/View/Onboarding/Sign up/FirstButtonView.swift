//
//  OnboardingButtonView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import SwiftUI

struct FirstButtonView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    var body: some View {
        ZStack {
            Button(action: {
                onboardingVM.nextView()
            }, label: {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: UIScreen.main.bounds.maxX - 75, height: 55)
                    .foregroundColor(Color("Green"))
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 3)
            })
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
