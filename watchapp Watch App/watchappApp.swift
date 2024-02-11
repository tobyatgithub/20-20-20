//
//  watchappApp.swift
//  watchapp Watch App
//
//  Created by Toby Huang on 2/9/24.
//

import SwiftUI
import UserNotifications

@main
struct watchapp_Watch_AppApp: App {
    let notificationDelegate = NotificationDelegate()
    init() {
        configureNotifications()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func configureNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print("Notification permission error: \(error)")
            }
        }
        // Assign your stored delegate here
        center.delegate = notificationDelegate
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // For watchOS, adjust this line according to what's supported and makes sense for your app.
        completionHandler([.banner, .list, .sound])
    }
}
