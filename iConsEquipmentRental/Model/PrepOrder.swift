//
//  Order.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import Foundation

struct PrepOrder: Identifiable {
    
    let id: String = UUID().uuidString
    
    let renterID: String
    let renterName: String
    let itemName: String
    let quantity: Int
    let rentalDate: Date
    let item: Item
    let delivery: Bool
    let deliveryLocation: String
    
}
