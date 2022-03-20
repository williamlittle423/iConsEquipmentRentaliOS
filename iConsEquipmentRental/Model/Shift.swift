//
//  Shift.swift
//  iCons
//
//  Created by William Little on 2022-03-01.
//

import Foundation

struct Shift: Identifiable {
    
    let id = UUID().uuidString
    
    let iConUID: String
    let startDate: Date
    let endDate: Date
    
}
