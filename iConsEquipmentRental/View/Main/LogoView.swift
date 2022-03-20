//
//  LogoView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 3, x: 0, y: 3)
                .opacity(0.2)
            Image("iConsLogo")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
        }
        .padding(.vertical)
    }
}
