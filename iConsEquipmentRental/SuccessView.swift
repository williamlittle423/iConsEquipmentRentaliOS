//
//  SuccessView.swift
//  iConsEquipmentRental
//
//  Created by William Little on 2022-03-14.
//

import SwiftUI

//To configure the contents of the HUD
struct HUDConfig {
    var text: String
    var iconName: String
    var color: Color
    var autohide = true
    
    static func success(_ s: String) -> HUDConfig {
        return HUDConfig(text: s, iconName: "checkmark.circle.fill", color: Color("Blue"))
    }
}

//Basically works like this:
//At first only icon is shown and with animation of 'appear' it pops up (scales from 0 to 1)
//Then after some delay the 'morph' flag gets set too.
//This means, the text appears,
//the icon gets scaled down to 0.4
//its opacity animates to 0
//it rotates
//and moves to the right :) all together
struct SuccessView: View {
    
    @State var morph = false
    @State var appear = false
    var config: HUDConfig
    
    var body: some View {
        Group {
                ZStack {
                    if morph {
                        Text(config.text)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                            .padding()
                            .transition(.opacity)
                    }
                    
                    Image(systemName: config.iconName)
                        .foregroundColor(config.color)
                        .font(Font.system(size: 24))
                        .padding()
                        .rotationEffect(.degrees(!morph ? 0 : 360))
                        .offset(x: !morph ? 0 : 90, y: 0)
                        .opacity(!morph ? 1 : 0)
                        .scaleEffect(!morph ? 3 : 1)
                }
        }
//        .background(Color.black.opacity(0.7))
        .scaleEffect(appear ? 1 : 0.0001)
        .onAppear {
           //transition, icon plops in
            withAnimation(Animation.spring()) {
                appear = true
            }
            //after some delay text appears and icon rolling disappears
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(Animation.spring().speed(0.3)) {
                    morph = true
                }
            }
        }
    }
    
}
