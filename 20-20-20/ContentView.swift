//
//  ContentView.swift
//  20-20-20
//
//  Created by Toby Huang on 2/9/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    let notificationIntervals = [1, 5, 15, 20] // Minutes
    @State private var selectedInterval = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select frequency", selection: $selectedInterval) {
                    ForEach(notificationIntervals, id: \.self) { interval in
                        Text("\(interval) mins").tag(interval)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                
                Button("Set Notification") {
                    scheduleNotification()
                }.buttonStyle(DefaultButtonStyle())
            }
            .padding()
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
        }
    }
    
    func scheduleNotification() {
        // Log the selected interval for debugging
        print("Scheduling notification for interval: \(selectedInterval) minutes")

        let content = UNMutableNotificationContent()
        content.title = "20-20-20"
        content.body = "It's time for your scheduled reminder."
        content.sound = .default

        // Calculate the time interval in seconds
        let timeInterval = TimeInterval(selectedInterval * 10)
        print("Time interval in seconds: \(timeInterval)")

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                // Log an error if the notification fails to schedule
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                // Confirm notification scheduling for debugging
                print("Notification scheduled successfully for \(self.selectedInterval) minutes later")
            }
        }
    }
}


#Preview {
    ContentView()
}
