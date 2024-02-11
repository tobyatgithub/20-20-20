////
////  InterfaceController.swift
////  watchapp Watch App
////
////  Created by Toby Huang on 2/9/24.
////
//
//import WatchKit
//import Foundation
//import UserNotifications
//
//class InterfaceController: WKInterfaceController {
//    var selectedInterval: TimeInterval = 300 // Default to 5 minutes
//    let intervalMapping: [String: TimeInterval] = [
//        "2 sec": 2,
//        "10 sec": 10,
//        "5 mins": 5 * 60,
//        "15 mins": 15 * 60,
//        "20 mins": 20 * 60,
//        "30 mins": 30 * 60
//    ]
//    
//    
//    func requestNotificationPermission() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//            if success {
//                print("Permission granted")
//            } else if let error = error {
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    
//    @IBAction func pickerDidChange(_ value: Int) {
//        let pickerOptions = ["5 mins", "15 mins", "30 mins"] // Ensure this matches the order of your picker items
//        let selectedOption = pickerOptions[value] // Get the selected string option
//        let interval = intervalMapping[selectedOption] ?? 0 // Lookup the interval, default to 0 if not found
//        scheduleNotification(interval: interval)
////        scheduleNotification(interval: <#T##String#>)
//    }
//    
//    func scheduleNotification(interval: TimeInterval) {
//        let content = UNMutableNotificationContent()
//        content.title = "Time's up!"
//        content.body = "Your selected timer has just finished."
//        content.sound = UNNotificationSound.default
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error scheduling notification: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    
//
//}
