//
//  Student.swift
//  iCons
//
//  Created by William Little on 2022-02-24.
//

import Foundation

struct Student: Identifiable {
    
    let id: String = UUID().uuidString
    
    let fullName: String
    let queensEmail: String
    let orderHistory: [FinalizedOrder]
    let owingToIcons: Float
    let outstandingItems: [FinalizedOrder]
    
}
