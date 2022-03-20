//
//  HorizontalItemsView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import SwiftUI

struct HorizontalItemsView: View {
    
    @EnvironmentObject var studentHomeVM: StudentHomeViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                
                // ALL ITEMS
                if studentHomeVM.selectedTab == "All" {
                    ForEach(studentHomeVM.allItems) { item in
                        HorizontalCardView(item: item)
                    }
                }
                
                // CHARGERS
                if studentHomeVM.selectedTab == "Chargers" {
                    
                    ForEach(studentHomeVM.chargerItems) { item in
                        HorizontalCardView(item: item)
                    }
                }
                
                // STATIONARY
                if studentHomeVM.selectedTab == "Stationary" {
                    
                    ForEach(studentHomeVM.stationaryItems) { item in
                        HorizontalCardView(item: item)
                    }
                }
                
                // TEXTBOOKS
                if studentHomeVM.selectedTab == "Textbooks" {
                    
                    ForEach(studentHomeVM.textbookItems) { item in
                        HorizontalCardView(item: item)
                    }
                }
                
                // COMPUTER ACCESSORIES
                if studentHomeVM.selectedTab == "Computer Accessories" {
                    
                    ForEach(studentHomeVM.computerAccessoriesItems) { item in
                        HorizontalCardView(item: item)
                    }
                }
            }
        })
    }
}


