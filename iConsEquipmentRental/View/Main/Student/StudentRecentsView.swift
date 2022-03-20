//
//  StudentRecentsView.swift
//  iCons
//
//  Created by William Little on 2022-02-24.
//

import SwiftUI

struct StudentRecentsView: View {
    
    @EnvironmentObject var rootVM: RootViewModel
    
    var body: some View {
        ZStack {
            if rootVM.orderHistory.count == 0 {
                ScrollView(.vertical, showsIndicators: false, content: {
                    Text("No orders yet")
                        .foregroundColor(Color("ItemPreviewTitle"))
                })
            } else {
                ScrollView(.vertical, showsIndicators: false, content: {
                    Text("somehow you have orders without being able to...")
                        .foregroundColor(Color("ItemPreviewTitle"))
                })
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct StudentRecentsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentRecentsView()
    }
}
