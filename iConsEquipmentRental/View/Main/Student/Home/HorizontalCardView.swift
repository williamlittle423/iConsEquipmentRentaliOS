//
//  HorizontalCardView.swift
//  iCons
//
//  Created by William Little on 2022-02-22.
//

import SwiftUI

struct HorizontalCardView: View {
    
    @StateObject var rentalVM = RentalViewModel()
    @EnvironmentObject var rootVM: RootViewModel
    
    let item: Item
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 150, height: 200)
                .foregroundColor(.white)
                .shadow(color: Color(.black).opacity(0.2), radius: 3, x: 1, y: 3)
            VStack(alignment: .center) {
                item.image
                    .resizable()
                    .frame(width: 65, height: 65)
                Text(item.name)
                    .foregroundColor(Color("ItemTitle"))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 140)
                    .padding(.vertical, 5)
                Text("\(item.currentStock) Available")
                    .font(.caption)
                    .foregroundColor(Color("TextGray"))

                NavigationLink(destination:
                                ItemPreviewView(item: item)
                ) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 70, height: 25)
                            .foregroundColor(Color("Green"))
                        HStack {
                            Group {
                                Text("Rent")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .offset(x: 10)
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 12, height: 9)
                            }
                            .frame(maxWidth: 30)
                        }
                    }
//                    .onTapGesture {
//                        rootVM.previewActive = true
//                  }
                }
                
            }
        }
        .environmentObject(rentalVM)
        .padding(.horizontal, 5)
        .padding(.vertical)
    }
}
