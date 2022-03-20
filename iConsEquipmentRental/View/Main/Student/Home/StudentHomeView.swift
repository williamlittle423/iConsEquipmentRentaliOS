//
//  StudentHomeView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import SwiftUI

struct StudentHomeView: View {
    
    @EnvironmentObject var studentHomeVM: StudentHomeViewModel
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            LogoView()
                .padding(.horizontal)
            HomeTitleView()
                .padding(.horizontal)
            ItemsTabView()
                .padding(.horizontal)
            HorizontalItemsView()
                .padding(.horizontal)
            
            Text("Your Recents")
                .fontWeight(.semibold)
                .font(.title2)
                .foregroundColor(Color("ItemPreviewTitle"))
                .padding()
            
            StudentRecentsView()
            
            Spacer()
        }
        .onAppear(perform: {
            studentHomeVM.retrieveItems()
        })
        .navigationBarHidden(true)

    }
}

struct StudentHomeView_Previews: PreviewProvider {
    static var previews: some View {
        StudentHomeView()
    }
}





