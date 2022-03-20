//
//  RentalViewModel.swift
//  iCons
//
//  Created by William Little on 2022-02-24.
//

import Foundation
import Firebase

class RentalViewModel: ObservableObject {
    
    init() {
        self.checkbox = true
    }
    
    // INPUT VARIABLES
    @Published var quantity: Int = 1
    @Published var deliveryLocation: String = ""
 
    // UI Variables
    @Published var previewActive: Bool = false
    @Published var showDelivery: Bool = false
    @Published var displayQuantityAlert: Bool = false
    @Published var checkbox: Bool = true

    func rentItem(item: Item) {
        self.previewActive = false
        
        let db = Firestore.firestore()
        
        let dateNow = Date.now
        let renterID = Auth.auth().currentUser!.uid
        let orderID = UUID().uuidString
        
        db.collection("items").whereField("name", isEqualTo: item.name).getDocuments { (query, err) in
            for doc in query!.documents {
                let data = doc.data()
                let itemUID = data["uid"] as! String
                let currentQuant = data["currentStock"] as! Int
                
                // SUFFICIENT QUANTITY CHECK
                if currentQuant < self.quantity {
                    self.displayQuantityAlert = true
                } else {
                    print("Item ID: \(itemUID)")
                    print("Item Name: \(item.name)")
                    print("New item quantity: \(currentQuant - self.quantity)")
                    
                    // UPDATES ITEM QUANTITY
                    db.collection("items").document(itemUID).updateData(["currentStock" : currentQuant - self.quantity])
                    
                    // ADDS TO ORDERS
                    db.collection("orders").addDocument(data: [
                        "renterID" : renterID as Any?,
                        "itemName" : item.name as Any?,
                        "deliveryLocation" : self.deliveryLocation,
                        "delivery" : self.deliveryLocation == "" ? false : true,
                        "processerID" : "",
                        "quantity" : self.quantity,
                        "dateRented" : dateNow,
                        "dateProcessed" : nil,
                        "returneDate" : nil,
                        "returned" : false,
                        "orderID" : orderID
                    ])
                }
                
            }
        }
    
        
        
                
    }
    
    func toggleCheckbox() {
        self.checkbox.toggle()
    }
}
