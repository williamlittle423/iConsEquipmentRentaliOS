//
//  RootViewModel.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import Foundation
import SwiftUI
import Firebase

class RootViewModel: ObservableObject {
    
    @AppStorage("signedIn") var signedIn: Bool = false
    @AppStorage("student") var student: Bool = false
    @AppStorage("onDuty") var onDuty: Bool = false
    
    // FLOW VARIABLES
    @Published var selectedTab: Int = 0
    @Published var previewActive: Bool = false
    @Published var singleInitital = false
    @Published var loading: Bool = false
    
    // STUDENT INFORMATION
    @Published var fullName: String = ""
    @Published var studentQueensEmail: String = ""
    @Published var itemsRented: Int = 0
    @Published var owingToIcons: Double = 0.0
    @Published var orderHistory: [FinalizedOrder] = []
    
    // ICON INFORMATION
    @Published var iConFullName: String = ""
    @Published var iConQueensEmail: String = ""
    @Published var ordersProcessed = [FinalizedOrder]()
    @Published var shiftHistory = []
    @Published var iConUID: String = ""
    
    // INITIALS FOR PROFILE VIEW
    @Published var firstInitial: String = ""
    @Published var lastIntitial: String = ""
        
    //
    func retrieveUserInfo() {
        
        let uid = Auth.auth().currentUser?.uid
        
        // NO USER SIGNED IN CASE
        if uid == nil {
            self.signedIn = false
            return
        }
        
        // DATABASE REFERENCE
        let db = Firestore.firestore()
        
        db.collection("students").whereField("uid", isEqualTo: uid!).getDocuments { (doc, err) in
            
            if let err = err {
                print("error obtaining current user information: \(err.localizedDescription)")
                return
            }
            
            
            for student in doc!.documents {
                let data = student.data()
                
                self.fullName = data["fullName"] as! String
                self.studentQueensEmail = data["queensEmail"] as! String
                self.owingToIcons = data["owingToIcons"] as! Double
                
                // USED FOR DETERMINING QUANTITY OF INITIALS IN FULL NAME
                let fullNameArr = self.fullName.components(separatedBy: " ")

                // ONE INTITIAL
                if fullNameArr.count == 1 {
                    
                    self.singleInitital = true
                    
                    let firstName = fullNameArr[0]
                    self.firstInitial = String(firstName[firstName.startIndex])
                    print("Single intital: \(fullNameArr)")
                    
                } else { // TWO INITIALS
                    
                    self.singleInitital = false
                    
                    let firstName: String = fullNameArr[0]
                    let lastName: String = fullNameArr[1]
                    
                    self.firstInitial = String(firstName[firstName.startIndex])
                    self.lastIntitial = String(lastName[lastName.startIndex])
                    print("More than one intial: \(fullNameArr)")
                }
                
                
                // TO BE CONTINUED
                self.itemsRented = self.orderHistory.count
                
            }
        }
        
    }
    
    func retreieveiConInfo() {
        let uid = Auth.auth().currentUser!.uid
        
        let db = Firestore.firestore()
        
        db.collection("iCons").document(uid).getDocument { doc, err in
            if let err = err {
                print("Error finding iCon in database: \(err.localizedDescription)")
            } else {
                let data = doc!.data()
                
                self.iConFullName = data?["fullName"] as! String
                self.iConQueensEmail = data?["email"] as! String
                self.iConUID = uid
                self.onDuty = data?["onCall"] as! Bool
                
                // TO BE CONTINUED...
                // shiftHistory
                // ordersProcessed
                
                
                // USED FOR DETERMINING QUANTITY OF INITIALS IN FULL NAME
                let fullNameArr = self.iConFullName.components(separatedBy: " ")
                print("Amount of words in full name: \(fullNameArr.count)")
                // ONE INTITIAL
                if fullNameArr.count == 1 {
                    
                    self.singleInitital = true
                    
                    let firstName = fullNameArr[0]
                    self.firstInitial = String(firstName[firstName.startIndex])
                    print("Single intital: \(fullNameArr)")
                    
                } else { // TWO INITIALS
                    
                    self.singleInitital = false
                    
                    let firstName: String = fullNameArr[0]
                    let lastName: String = fullNameArr[1]
                    
                    self.firstInitial = String(firstName[firstName.startIndex])
                    self.lastIntitial = String(lastName[lastName.startIndex])
                    print("More than one intial: \(fullNameArr)")
                }
                
            }
        }
        
        
    }
    
    func rentItem() {
        self.previewActive = false
    }
    
    
}
