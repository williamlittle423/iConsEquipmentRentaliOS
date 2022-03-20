//
//  OnboardingViewModel.swift
//  iCons
//
//  Created by William Little on 2022-02-16.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

class OnboardingViewModel: ObservableObject {
    
    // PERMANENT VARIABLE
    @AppStorage("signedin") var signedIn = false
    @AppStorage("iCon") var iCon = false
    @AppStorage("student") var student = false
    
    // FLOW VARIABLES
    @Published var studentOrIcon: Int = 0
    @Published var progressValue: CGFloat = 0.5
    @Published var onboardingView: Int = 0
    @Published var buttonText: String = "Get Started"
    @Published var loading: Bool = false
    @Published var displaySignin: Bool = false
    
    // ALERT ERROR VARIABLES
    @Published var displayAccessCodeAlert: Bool = false
    @Published var displayInUseAlert: Bool = false
    @Published var displaySignupAlert: Bool = false
    @Published var displayEmailAlert: Bool = false
    @Published var displayPasswordAlert: Bool = false
    @Published var displaySignupError: Bool = false
    
    // STUDENT INFO
    @Published var fullName: String = ""
    @Published var studentQueensEmail: String = ""
    @Published var password: String = ""
    @Published var passwordReEnter: String = ""
    
    // ICON INFO
    @Published var iConFullName: String = ""
    @Published var iConQueensEmail: String = ""
    @Published var accessCode: String = ""
    
    
    // ONBOARDING BUTTON
    func nextView() {
        
        self.progressValue = 1.0
        self.onboardingView += 1
        self.buttonText = "Sign Up"
        
        
    }
    
    // SIGNS CURRENT USER OUT
    func signout() {
        
        self.loading = true
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out")
            self.loading = false
        }
        
        self.iCon = false
        self.student = false
        self.signedIn = false
        self.loading = false
    }
    
    // STUDENT SIGN UP
    func studentSignup() -> Void {
        
        // BEGINS PROGRESS VIEW
        self.loading = true
        
        // MAKES SURE STUDENT INFO IS CORRECT BEFORE SIGNING UP
        checkStudent()
        
        // CREATES USER IN FIREBASE AUTHENTICATION AND FIRESTORE
        Auth.auth().createUser(withEmail: studentQueensEmail, password: password) { (result, err) in
            
            if let err = err {
                print("Error signing up : \(err.localizedDescription)")
                self.displaySignupError = true
                self.loading = false
                return
            }
            
            print("Success")
                        
            let db = Firestore.firestore()
            
            let uid = Auth.auth().currentUser?.uid
            
            let ref = db.collection("students")
            
            ref.addDocument(data:
                [ "fullName" : self.fullName,
                  "queensEmail" : self.studentQueensEmail,
                  "orderHistory" : [],
                  "owingToIcons" : 0.0,
                  "outstandingItems" : [],
                  "uid" : uid!
                ])
            
            self.student = true
            self.signedIn = true
            self.loading = false
        }
        
    }
    
    func studentSignin() {
        
        self.loading = true
        
        Auth.auth().signIn(withEmail: studentQueensEmail, password: password) { (authResult, err) in
            if let err = err {
                print("Error signing in student: \(err.localizedDescription)")
                self.loading = false
                self.displaySignupError = true
                return
            }
        }
        
        self.student = true
        self.signedIn = true
        self.loading = false
        
    }
    
    // ICON SIGN IN
    func iConSignin() {
        
        self.loading = true
        
        Auth.auth().signIn(withEmail: iConQueensEmail, password: accessCode) { (result, err) in
            if let err = err {
                print("Error signing in iCon: \(err.localizedDescription)")
                self.loading = false
                self.displaySignupError = true
                return
            } else {
                self.iCon = true
                self.signedIn = true
                self.loading = false
            }
        }
    
    }
    
    // CHECKS STUDENT FIELDS TO MAKE SURE INFORMATION IS CORRECT
    func checkStudent() {
        
        let lowercaseEmail: String = self.studentQueensEmail.lowercased()
        
        if !lowercaseEmail.contains("@queensu.ca") {
            self.displayEmailAlert = true
            return
        }
        
        if password != passwordReEnter {
            self.displayPasswordAlert = true
            return
        }
        
        if fullName == "" || studentQueensEmail == ""  || password == "" || passwordReEnter == "" {
            self.displaySignupAlert = true
            return
        }
    }
    
    // ICON SIGN UP
    func iConSignup() {
        
        self.loading = true
        
        // DATABASE REFERENCE
        let db = Firestore.firestore()
        
        if iConFullName == "" || iConQueensEmail == "" || accessCode == ""  {
            self.displaySignupAlert = true
            self.loading = false
            return
        }
        
        db.collection("accessCodes").whereField("accessCode", isEqualTo: self.accessCode).getDocuments { query, err in
            if let err = err {
                print("Error accessing codes: \(err.localizedDescription)")
                self.displaySignupError = true
                self.loading = false
                return
            }
            
            // NO MATCHING ACCESS CODES TO INPUT IF TRUE
            if query!.documents.count == 0 {
                print("NO ACCESS CODE MATCHES")
                self.displaySignupError = true
                self.loading = false
                return
            }
            
            for code in query!.documents {
                let data = code.data()
                let inUse = data["inUse"] as! Bool
                
                // CHECKS IF ACCESS CODE IS IN USE
                if inUse {
                    self.displaySignupError = true
                    self.loading = false
                    return
                }
            }
            
            // FIREBASE AUTHENTICATION
            Auth.auth().createUser(withEmail: self.iConQueensEmail, password: self.accessCode) { res, err in
                if let err = err {
                    print("Error creating user: \(err.localizedDescription)")
                    self.displaySignupError = true
                    self.loading = false
                }
                
                let uid = res?.user.uid ?? ""
                
                // UPLOADS USER INFORMATION TO DATABASE
                db.collection("iCons").document(uid).setData([
                    "fullName" : self.iConFullName,
                    "email" : self.iConQueensEmail,
                    "accessCode" : self.accessCode,
                    "uid" : uid,
                    "ordersProcessed" : [],
                    "onCall" : false
                ])
                
                // SETS ACCESS CODE TO "IN USE" IN DATABASE
                db.collection("accessCodes").whereField("accessCode", isEqualTo: self.accessCode).getDocuments { query, err in
                    if let err = err {
                        print("Error finding access code: \(err.localizedDescription)")
                        self.loading = false
                        self.displaySignupError = true
                        return
                    }
                    
                    for code in query!.documents {
                        let data = code.data()
                        let uid = data["uid"] as! String
                        
                        db.collection("accessCodes").document(uid).updateData(["inUse" : true])
                    }
                }
                
                // SETS APP STORAGE VARIABLE TO TRUE (SIGNED IN)
                self.signedIn = true
                self.iCon = true
                self.loading = false
            }
            
        }
    }
    
}
