//
//  ReminderConfig.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 26.09.2023.
//

import SwiftUI

struct ReminderSection {
    let category: String
    let key: String
    let title: String
    let text: String
}

struct ReminderConfig {
        @State private var feedWaterReminders: [ReminderObject] = UserDefaults.standard.remindersForKey("feedWaterReminders")
    
        @State private var walkExerciseReminders: [ReminderObject] = UserDefaults.standard.remindersForKey("walkExerciseReminders")
    
    let reminderSections: [ReminderSection] = [
        ReminderSection(category: "Feed & Water Reminders", key: "feedWaterReminders", title: "Feed your Pet!", text: "Its time to feed your pet!"),
        ReminderSection(category: "Walk/Exercise Reminders", key: "walkExerciseReminders", title: "Walk your Pet!", text: "Its time to walk your pet!"),
        // Add more sections as needed
    ]
}


