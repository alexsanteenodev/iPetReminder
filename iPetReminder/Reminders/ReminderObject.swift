//
//  ReminderObject.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 25.09.2023.
//

import Foundation

struct ReminderObject: Identifiable, Codable, Hashable {
    let id:UUID
    let reminderString: String
    let isRecuring: Bool
    let date: Date?
    let dateComponent: DateComponents?
    let title: String
    let description: String
}
