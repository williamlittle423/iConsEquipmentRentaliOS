//
//  Item.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import Foundation
import UIKit
import SwiftUI
import SDWebImageSwiftUI

struct Item: Identifiable {
    
    let id: String = UUID().uuidString
    
    let name: String
    let category: String
    let imageURL: String
    let currentStock: Int
    let totalStock: Int
    let image: AnimatedImage
    
    
}
