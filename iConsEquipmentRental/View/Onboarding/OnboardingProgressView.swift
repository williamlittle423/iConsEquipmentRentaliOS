//
//  ProgressView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import SwiftUI

struct OnboardingProgressView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 3, x: 0, y: 3)
                .opacity(0.2)
            ZStack {
                Circle()
                    .stroke(lineWidth: 2.0)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                Circle()
                    .trim(from: 0, to: onboardingVM.progressValue)
                    .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(onboardingVM.studentOrIcon == 0 ? Color("Green") : Color("Blue"))
                
            }
            .frame(width: 80, height: 80)
            Image("iConsLogo")
                .resizable()
                .frame(width: 48, height: 48, alignment: .center)
        }
    }
}
