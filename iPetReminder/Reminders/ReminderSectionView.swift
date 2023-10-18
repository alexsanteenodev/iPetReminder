//
//  ReminderSectionView.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 25.09.2023.
//

import SwiftUI

struct ReminderSectionView: View {
    var category: String
    var key: String
    @Binding var reminders: [ReminderObject]
    var title: String
    var text: String
    var addImage: String
    var notification = Notification()
    var body: some View {
        Section(header: Text(category)) {
                List {
                    ForEach(reminders, id: \.self) { reminder in
                        HStack {
                            Text(reminder.reminderString)
                        }
                    }
                    .onDelete(perform: delete)
                }

            NavigationLink(destination: ReminderEditView(addReminder: add)) {
                HStack {
                    Image(systemName: addImage)
                    Text("Add Reminder")
                }
            }
        }
        
      
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let reminder = reminders[index]
            notification.removeNotification(withUUID: reminder.id) // Assuming `id` is the UUID
        }
        
        reminders.remove(atOffsets: offsets)
        UserDefaults.standard.setReminders(reminders, forKey: key)
    }
    
    func add(newReminder:ReminderObject){
        reminders.append(newReminder)
        
        UserDefaults.standard.setReminders(reminders, forKey: key)

        let reminderTitle = newReminder.title == "" ?  title : newReminder.title
        let reminderDescription = newReminder.description == "" ? text : newReminder.description
        
        if !newReminder.isRecuring {
            notification.setNotificationFromDate(date:newReminder.date ?? Date(), id: newReminder.id, title: reminderTitle, text:reminderDescription, repeats:false)
        }else if newReminder.dateComponent != nil {
            notification.setNotificationFromDateComponents( components :newReminder.dateComponent ?? DateComponents(), id: newReminder.id, title: reminderTitle, text:reminderDescription, repeats:false)
        }
    }
    
}

struct ReminderSectionView_Previews: PreviewProvider {
    @State private static var walkExerciseReminders: [ReminderObject] = UserDefaults.standard.remindersForKey("walkExerciseReminders")
    
    static var image = "system.plus"
    
    static var previews: some View {
        ReminderSectionView(category: "Walk/Exercise Reminders",key:"walkExerciseReminders", reminders: $walkExerciseReminders, title:"Walk your Pet!", text: "Its time to walk your pet!", addImage:image)
    }
}


