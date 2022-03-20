//
//  TitleView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import SwiftUI

struct TitleView: View {
    
    
    var body: some View {
        VStack {
            Text("Welcome to iCon's")
                .font(Font.system(size: 25, design: .default))
                .fontWeight(.semibold)
                .offset(y: -45)
            
            // Welcome Line 2
            Text("Equipment Rental App")
                .font(Font.system(size: 25, design: .default))
                .fontWeight(.semibold)
                .offset(y: -45)
            
            
            // Secondary line
            Text("Streamlining the equipment rental process")
                .foregroundColor(.gray)
                .offset(y: -24)
        }
    }
}
