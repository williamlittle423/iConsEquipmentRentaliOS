//
//  HomeTitleView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import SwiftUI

struct HomeTitleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("iCons Equipment Rental")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Available for pickup at the ILC")
                .font(.footnote)
                .foregroundColor(Color("TextGray"))
            RoundedRectangle(cornerRadius: 1)
                .frame(width: UIScreen.main.bounds.maxX - 30, height: 1, alignment: .center)
                .foregroundColor(Color("ButtonGray"))
                .padding(.vertical)
        }
    }
}
