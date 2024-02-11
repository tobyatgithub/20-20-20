//
//  _0_20_20App.swift
//  20-20-20
//
//  Created by Toby Huang on 2/9/24.
//

import SwiftUI

@main
struct _0_20_20App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Choose how to present the notification in the foreground
        print("Foreground setting for app delegate called.")
        completionHandler([.banner, .sound])
    }

    
    // Handle notification tap while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Determine how to navigate to MessageView based on your app's structure
        print("Notification tapped. Navigate to MessageView.")
        completionHandler()
    }
}

class NavigationCoordinator: ObservableObject {
    @Published var selectedPage: String? = nil
}
