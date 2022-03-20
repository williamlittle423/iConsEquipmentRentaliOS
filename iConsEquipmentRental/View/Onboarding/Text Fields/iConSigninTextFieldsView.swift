//
//  iConSigninTextFieldsView.swift
//  iCons
//
//  Created by William Little on 2022-02-26.
//

import SwiftUI

struct iConSigninTextFieldsView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            ZStack {
                TextField("Queen's Email", text: $onboardingVM.iConQueensEmail)
                    .autocapitalization(.none)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("ButtonGray"), lineWidth: 2)
                            .frame(width: UIScreen.main.bounds.maxX - 50, height: 60, alignment: .center)
                    )
            }
            .padding(.horizontal, 50)
            
            ZStack {
                SecureField("iCons Access Code", text: $onboardingVM.accessCode)
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

struct iConSigninTextFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        iConSigninTextFieldsView()
    }
}
