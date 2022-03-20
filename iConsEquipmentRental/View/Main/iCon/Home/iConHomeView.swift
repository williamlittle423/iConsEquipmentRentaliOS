//
//  iConHomeView.swift
//  iCons
//
//  Created by William Little on 2022-03-01.
//

import SwiftUI

struct iConHomeView: View {
    
    @EnvironmentObject var iConVM: iConViewModel
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading) {
                
                Text("Items For Preparation")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                ForEach(iConVM.prepOrders) { prepOrder in
                    PrepOrderView(prepOrder: prepOrder)
                }
                
            }
            
            if !iConVM.onDuty {
                Button(action: {
                    iConVM.beginShift()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 200, height: 60)
                            .foregroundColor(Color("Blue"))
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 1, y: 3)
                        Text("Start Shift")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.vertical, 100)
                })
            }
            
        }
        .onAppear(perform: {
            iConVM.retrieveItemsForPrep()
        })
        .refreshable {
            await iConVM.reload()
        }
    }
}

struct iConHomeView_Previews: PreviewProvider {
    static var previews: some View {
        iConHomeView()
    }
}
