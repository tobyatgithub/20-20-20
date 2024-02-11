//
//  ContentView.swift
//  watchapp Watch App
//
//  Created by Toby Huang on 2/9/24.
//

import SwiftUI
import UserNotifications
import WatchKit

struct ContentView: View {
    let notificationIntervals = ["2 sec", "10 sec", "5 mins", "15 mins", "20 mins", "30 mins"]
    @State private var selectedInterval = "2 sec"
    @State private var remainingTime: TimeInterval = 0
    @State private var isActive = false // To control the countdown timer
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            Picker("Notification Interval", selection: $selectedInterval) {
                ForEach(notificationIntervals, id: \.self) { interval in
                    Text(interval).tag(interval)
                }
            }
            .pickerStyle(.wheel)
            
            Button("Start Countdown") {
                requestNotificationPermission()
                startCountdown(for: selectedInterval)
            }
            
            if remainingTime > 0 {
                Text("Remaining Time: \(Int(remainingTime)) seconds")
            }
        }
        .padding()
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print("Notification permission denied because: \(error.localizedDescription).")
            }
        }
    }

    func startCountdown(for interval: String) {
        // Convert the interval to seconds
        let seconds = intervalInSeconds(for: interval)
        self.remainingTime = seconds
        
        // Invalidate any existing timer
        self.timer?.invalidate()
        
        // Start a new timer
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            DispatchQueue.main.async {
                if self.remainingTime > 0 {
                    self.remainingTime -= 1
                } else {
                    self.timer?.invalidate()
                    self.scheduleNotification()
                }
            }
        }
    }

    private func intervalInSeconds(for interval: String) -> TimeInterval {
        switch interval {
        case "2 sec":
            return 2
        case "10 sec":
            return 10
        case "5 mins":
            return 300 // 5 * 60
        case "15 mins":
            return 900 // 15 * 60
        case "20 mins":
            return 1200 // 20 * 60
        case "30 mins":
            return 1800 // 30 * 60
        default:
            return 0 // Default case
        }
    }

    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Time's up!"
        content.body = "Your selected timer has just finished."
        content.sound = UNNotificationSound.default

        // Trigger notification to fire immediately after countdown finishes
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled!")
            }
        }
    }
}


#Preview {
    ContentView()
}
