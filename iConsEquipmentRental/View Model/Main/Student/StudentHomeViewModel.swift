//
//  StudentHomeViewModel.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import Foundation
import SwiftUI
import Firebase
import SDWebImageSwiftUI

@MainActor
class StudentHomeViewModel: ObservableObject {
    
    init() {
        
        // PREPARES LISTS UPON INITIALIZATION
        retrieveItems()
        
    }
    
    // HORIZONTAL TAB SELECTION
    @Published var selectedTab: String = "All"
    
    @Published var tempQuant: Int = 1
    @Published var deliverLocation: String = ""
    
    // ITEMS
    @Published var allItems = [Item]()
    @Published var stationaryItems = [Item]()
    @Published var chargerItems = [Item]()
    @Published var textbookItems = [Item]()
    @Published var computerAccessoriesItems = [Item]()
    
    func retrieveItems() {
        
        // DATABASE REFERENCE VARIABLE
        let db = Firestore.firestore()
        
        // RETRIEVES CURRENT QUERY SNAPSHOT
        db.collection("items").getDocuments { (querySnapshot, err) in
            
            if let err = err {
                print("Error retrieving item: \(err.localizedDescription)")
            } else {
                
                // LOOPS THROUGH EACH ITEM
                for item in querySnapshot!.documents {
                    let data = item.data()
                    
                    let newItem = Item(
                        name: data["name"] as! String,
                        category: data["category"] as! String,
                        imageURL: data["imageURL"] as! String,
                        currentStock: data["currentStock"] as! Int,
                        totalStock: data["totalStock"] as! Int,
                        image: AnimatedImage(url: URL(string: data["imageURL"] as! String)))

                    self.allItems.append(newItem)
                    
//                    print("adding \(data["name"] as! String) to the ALL list")
                }
            }
            
        }
        
        
        // STATIONARY ITEMS
        db.collection("items").whereField("category", isEqualTo: "stationary").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error retrieving stationary items: \(err.localizedDescription)")
            } else {
                for item in querySnapshot!.documents {
                    
                    let data = item.data()
                    
                    // DEPENDENT ON CATEGORY ARGUMENT
//                    print("adding \(data["name"] as! String) to stationary")
                    
                    self.stationaryItems.append(
                        Item(name: data["name"] as! String,
                             category: data["category"] as! String,
                             imageURL: data["imageURL"] as! String,
                             currentStock: data["currentStock"] as! Int,
                             totalStock: data["totalStock"] as! Int,
                             image: AnimatedImage(url: URL(string: data["imageURL"] as! String)))
                    )
                }
            }
        }
        
        // CHARGER ITEMS
        db.collection("items").whereField("category", isEqualTo: "chargers").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error retrieving charger items: \(err.localizedDescription)")
            } else {
                for item in querySnapshot!.documents {
                    
                    let data = item.data()
                                        
                    self.chargerItems.append(
                        Item(name: data["name"] as! String,
                             category: data["category"] as! String,
                             imageURL: data["imageURL"] as! String,
                             currentStock: data["currentStock"] as! Int,
                             totalStock: data["totalStock"] as! Int,
                             image: AnimatedImage(url: URL(string: data["imageURL"] as! String)))
                    )
                }
            }
        }
        
        // COMPUTER ACCESSORY ITEMS
        db.collection("items").whereField("category", isEqualTo: "computerAccessories").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error retrieving computer accessory items: \(err.localizedDescription)")
            } else {
                for item in querySnapshot!.documents {
                    
                    let data = item.data()
                                        
                    self.computerAccessoriesItems.append(
                        Item(name: data["name"] as! String,
                             category: data["category"] as! String,
                             imageURL: data["imageURL"] as! String,
                             currentStock: data["currentStock"] as! Int,
                             totalStock: data["totalStock"] as! Int,
                             image: AnimatedImage(url: URL(string: data["imageURL"] as! String)))
                    )
                }
            }
        }
        
        // TEXTBOOK ITEMS
        db.collection("items").whereField("category", isEqualTo: "textbooks").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error retrieving textbook items: \(err.localizedDescription)")
            } else {
                for item in querySnapshot!.documents {
                    
                    let data = item.data()
                    
                    // DEPENDENT ON CATEGORY ARGUMENT
                    
                    self.textbookItems.append(
                        Item(name: data["name"] as! String,
                             category: data["category"] as! String,
                             imageURL: data["imageURL"] as! String,
                             currentStock: data["currentStock"] as! Int,
                             totalStock: data["totalStock"] as! Int,
                             image: AnimatedImage(url: URL(string: data["imageURL"] as! String)))
                    )
                }
            }
        }
    }
}
