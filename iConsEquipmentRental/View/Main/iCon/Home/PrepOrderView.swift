//
//  PrepOrderView.swift
//  iCons
//
//  Created by William Little on 2022-03-02.
//

import SwiftUI
import SDWebImageSwiftUI

struct PrepOrderView: View {
    
    @EnvironmentObject var iConVM: iConViewModel
    let prepOrder: PrepOrder
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: UIScreen.main.bounds.maxX - 40, height: 240)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 1, y: 5)
            
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(prepOrder.item.name)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("ItemPreviewTitle"))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 150)
                        prepOrder.item.image
                            .resizable()
                            .frame(width: 75, height: 75)
                            .padding(.horizontal, 30)
                    }
                    .padding(.horizontal, 30)
                    
                    Group {
                        HStack {
                            Text("Rented By:").font(Font.custom("Helvetica Neue", size: 14)).fontWeight(.light)
                            Text(prepOrder.renterName)
                                .font(Font.custom("Helvetica Neue", size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("ItemPreviewTitle"))
                        }
                        if prepOrder.delivery {
                            HStack {
                                Text("Delivery Location:").font(Font.custom("Helvetica Neue", size: 14)).fontWeight(.light)
                                Text(prepOrder.deliveryLocation)
                                    .font(Font.custom("Helvetica Neue", size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("ItemPreviewTitle"))
                            }
                        }
                        HStack {
                            Text("Quantity:")
                                .font(Font.custom("Helvetica Neue", size: 14)).fontWeight(.light)
                            Text(String(prepOrder.quantity))
                                .font(Font.custom("Helvetica Neue", size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("ButtonBlue"))
                        }
                        HStack {
                            Text("Processed:").font(Font.custom("Helvetica Neue", size: 14)).fontWeight(.light)
                            Text(String(prepOrder.rentalDate.formatted()))
                                .font(Font.custom("Helvetica Neue", size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("ButtonBlue"))
                        }
                    }
                    .padding(.horizontal, 30)
                }
                
                
                
                Button(action: {
                    Void()
                }, label: {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 130, height: 35)
                            .foregroundColor(Color("ButtonBlue"))
                            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 3)
                        HStack {
                            Text("Delivered")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .frame(width: 8, height: 8)
                                .padding(.horizontal, 5)
                        }
                    }
                })
            }
        }
    }
}
