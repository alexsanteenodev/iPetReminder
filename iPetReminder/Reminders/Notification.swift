//
//  Notification.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 25.09.2023.
//

import Foundation

import UserNotifications

struct Notification {
    

    func removeNotification(withUUID uuid: UUID) {
        let identifier = uuid.uuidString
        
        // Create an instance of UNUserNotificationCenter
        let center = UNUserNotificationCenter.current()
        
        // Remove the notification request with the specified identifier
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    func setNotificationFromDateComponents(components: DateComponents, id:UUID, title: String, text:String, repeats:Bool) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = text
        content.sound = .default
        content.badge = 1 // You can set this to the number you want to appear on the app's badge icon.

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats:true)

        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
        
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                print("Error adding notification request: \(error)")
            } else {
                print("Pet reminder notification scheduled successfully.")
            }
        }
        
    }
    
    func setNotificationFromDate(date: Date, id:UUID, title: String, text:String, repeats:Bool) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = text
        content.sound = .default
        content.badge = 1 // You can set this to the number you want to appear on the app's badge icon.
        
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats:false)

        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
        
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                print("Error adding notification request: \(error)")
            } else {
                print("Pet reminder notification scheduled successfully.")
            }
        }
    }
    
    func loadPendingNotifications() {
            let center = UNUserNotificationCenter.current()
            center.getPendingNotificationRequests { requests in
                DispatchQueue.main.async {
                    for request in requests {
                        // Print notification data to the console
                        
                        print("request:",request )
  
                        print("-------------")
                    }
                }
            }
        }
}
