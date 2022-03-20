//
//  iConsEquipmentRentalApp.swift
//  iConsEquipmentRental
//
//  Created by William Little on 2022-03-03.
//

import SwiftUI
import Firebase

@main
struct iConsEquipmentRentalApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        // FIREBASE CONFIGURATION
        FirebaseApp.configure()
        
        // SETTING UP FIREBASE CLOUD MESSAGING
        Messaging.messaging().delegate = self
        
        // SETTING UP NOTIFICATIONS
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)
                       -> Void) {

      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // THESE MUST BE IMPLEMENTED TO RECIEVE NOTIFICATIONS
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        // ADDS TOKEN TO FIRESTORE USER DATA
        let db = Firestore.firestore()
        
        
        // IF STUDENT IS SIGNED IN
        if let uid = Auth.auth().currentUser?.uid {

            db.collection("students").whereField("uid", isEqualTo: uid).getDocuments { (query, err) in
                if let err = err {
                    print("Error fetching student from current user UID: \(err.localizedDescription)")
                    return
                }

                // CONFIRMS THERE IS A STUDENT
                if query?.documents.count != 0 {
                    for student in query!.documents {
                        let documentID = student.documentID

                        // SETS TOKEN FIELD
                        print("ADDED TOKEN!")
                        db.collection("students").document(documentID).updateData(["fcmToken" : fcmToken ?? ""])
                    }
                }
            }
        }
        
        // IF ICON IS SIGNED IN
        if let uid = Auth.auth().currentUser?.uid {
            
            db.collection("iCons").whereField("uid", isEqualTo: uid).getDocuments { (query, err) in
                if let err = err {
                    print("Error finding iCon in Firestore \(err.localizedDescription)")
                    return
                }
                
                // CONFIRMS THERE IS A STUDENT
                if query?.documents.count != 0 {
                    for iCon in query!.documents {
                        let documentID = iCon.documentID

                        // SETS TOKEN FIELD
                        print("Added token to iCon profile: \(fcmToken as? String ?? "NO TOKEN")")
                        db.collection("iCons").document(documentID).updateData(["fcmToken" : fcmToken ?? ""])
                    }
                }
            }
        }

        let dataDict: [String: String] = ["token": fcmToken ?? ""]

        print(dataDict)

    }
    
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification,
                                  withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                    -> Void) {
        let userInfo = notification.request.content.userInfo

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // ...

        // Print full message.
        print(userInfo)

        // Change this to your preferred presentation option
          completionHandler([[.banner, .badge, .sound]])
      }

      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  didReceive response: UNNotificationResponse,
                                  withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        // ...

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print full message.
        print(userInfo)

        completionHandler()
      }
    
}
