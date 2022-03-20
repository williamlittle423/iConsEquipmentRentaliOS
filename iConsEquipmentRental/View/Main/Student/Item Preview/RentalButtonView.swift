//
//  RentalButtonView.swift
//  iCons
//
//  Created by William Little on 2022-02-26.
//

import SwiftUI

struct RentalButtonView: View {
    
    @EnvironmentObject var rentalVM: RentalViewModel
    @EnvironmentObject var rootVM: RootViewModel
    
    let item: Item
    
    var body: some View {
        ZStack {
            Button(action: {
                rentalVM.rentItem(item: item)
            }, label: {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: UIScreen.main.bounds.maxX - 75, height: 55)
                    .foregroundColor(Color("ButtonBlue"))
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 3)
            })
            HStack {
                Text(rentalVM.showDelivery ? "Confirm Delivery" : "Confirm Pickup")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .offset(x: 15)
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
                    .frame(width: 18, height: 15)
                    .offset(x: 70)
            }
        }
        .alert("Insufficient Quantity Available", isPresented: $rentalVM.displayQuantityAlert) {
            Button("OK", role: .cancel) { }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
    }
}
