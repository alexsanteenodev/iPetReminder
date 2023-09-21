//
//  UserDefaults+Extension.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 25.09.2023.
//

import Foundation

extension UserDefaults {
    func remindersForKey(_ key: String) -> [ReminderObject] {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let reminders = try? JSONDecoder().decode([ReminderObject].self, from: data) {
                return reminders
            }
        }
        return []
    }
    
    func setReminders(_ reminders: [ReminderObject], forKey key: String) {
        if let data = try? JSONEncoder().encode(reminders) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
