//
//  Notification.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 25.09.2023.
//

import Foundation
import UserNotifications
import UIKit

struct Notification {
    // Add helper function to get profile image
    private func getProfileImage() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    private func addImageAttachment(_ content: UNMutableNotificationContent) {
        if let image = getProfileImage() {
            // Create a temporary URL to store the image
            let temporaryDirectoryURL = FileManager.default.temporaryDirectory
            let imageURL = temporaryDirectoryURL.appendingPathComponent("petImage.png")
            
            // Convert image to PNG data and write to temporary file
            if let imageData = image.pngData() {
                try? imageData.write(to: imageURL)
                
                // Create attachment
                if let attachment = try? UNNotificationAttachment(
                    identifier: "petImage",
                    url: imageURL,
                    options: nil
                ) {
                    content.attachments = [attachment]
                }
            }
        } else {
            // If no image, show badge
            content.badge = 1
        }
    }

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
        
        // Add image attachment if available, otherwise add badge
        addImageAttachment(content)

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
        
        // Add image attachment if available, otherwise add badge
        addImageAttachment(content)
        
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
