//
//  iConViewModel.swift
//  iCons
//
//  Created by William Little on 2022-03-01.
//

import Foundation
import Firebase
import SwiftUI
import SDWebImageSwiftUI

class iConViewModel: ObservableObject {
    
    @AppStorage("onDuty") var onDuty = false
    @AppStorage("currentShift") var currentShift = ""
    
    @Published var prepOrders = [PrepOrder]()
    @Published var currRented = [RentedOrder]()
    
    // STARTS ICONS SHIFT
    func beginShift() {
        
        let db = Firestore.firestore()
        let uid: String = Auth.auth().currentUser!.uid
        
        db.collection("iCons").document(uid).updateData(["onCall" : true])
        self.onDuty = true
        
        let startDate: Date = Date.now
        
        let shiftID = UUID().uuidString
        self.currentShift = shiftID
        
        db.collection("shifts").document(shiftID).setData(["iConUID" : uid,
                                                           "shiftID" : shiftID,
                                                           "startDate" : startDate,
                                                           "endDate" : nil])
        
    }
    
    // ENDS ICONS SHIFT
    func endShift() {
        
        let db = Firestore.firestore()
        let uid: String = Auth.auth().currentUser!.uid
        
        db.collection("iCons").document(uid).updateData(["onCall" : false])
        self.onDuty = false
        
        let endDate: Date = Date.now
        
        db.collection("shifts").document(self.currentShift).updateData(["endDate" : endDate])
        
        self.currentShift = ""
        
    }
    
    func finishDelivery() {
        
    }
    
    func retrieveItemsForPrep() {
        
        let db = Firestore.firestore()
        
        // ALL ORDERS THAT HAVE NOT BEEN PROCESSED
        db.collection("orders").whereField("processerID", isEqualTo: "").getDocuments { query, err in
            if let err = err {
                print("Error retrieving orders for preparation: \(err.localizedDescription)")
                return
            }
            
            for doc in query!.documents {
                let data = doc.data()
                
                // RENTAL INFORMATION
                let renterID = data["renterID"] as? String ?? ""
                let quantity = data["quantity"] as? Int ?? 0
                let dateRented = data["dateRented"] as! Date
                let delivery = data["delivery"] as! Bool
                let deliveryLocation = data["deliveryLocation"] as? String ?? ""
                
                // ITEM INFORMATION
                let itemName: String = ""
                var imageURL: String = ""
                var image: AnimatedImage = AnimatedImage(url: URL(string: imageURL))
                var currentStock: Int = 0
                var category: String = ""
                var totalStock: Int = 0
                
                // STUDENT INFORMATION
                var studentName: String = ""
                
                // RETRIEVES ITEM DATA
                db.collection("items").whereField("itemName", isEqualTo: itemName).getDocuments { (query, err) in
                    if let err = err {
                        print("Error retrieving item from item name in Firestore: \(err.localizedDescription)")
                        return
                    }
                    
                    for doc in query!.documents {
                        let itemData = doc.data()
                        
                        imageURL = data["imageURL"] as! String
                        image = AnimatedImage(url: URL(string: imageURL))
                        currentStock = itemData["currentStock"] as? Int ?? 0
                        category = itemData["category"] as? String ?? ""
                        totalStock = itemData["totalStock"] as? Int ?? 0
                        
                        
                    }
                }
                
                // RETREIVES RENTERS DATA
                db.collection("students").whereField("uid", isEqualTo: renterID).getDocuments { (query, err) in
                    if let err = err {
                        print("Order finding student in Firestore: \(err.localizedDescription)")
                        return
                    }
                    
                    for student in query!.documents {
                        let studentData = student.data()
                        
                        studentName = studentData["fullName"] as? String ?? "NO NAME"
                    }
                }
                
                // ADDS PREPARATION ORDER TO VIEW MODELS ARRAY
                self.prepOrders.append(PrepOrder(renterID: renterID,
                          renterName: studentName,
                          itemName: itemName,
                          quantity: quantity,
                          rentalDate: dateRented,
                          item: Item(name: itemName,
                                     category: category,
                                     imageURL: imageURL,
                                     currentStock: currentStock,
                                     totalStock: totalStock,
                                     image: image), delivery: delivery,
                          deliveryLocation: deliveryLocation))
                
            }
        }
    }
    
    func reload() async {
        retrieveItemsForPrep()
    }
}
