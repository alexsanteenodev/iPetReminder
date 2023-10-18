//
//  ReminderView.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 16.09.2023.
//

import SwiftUI


struct ReminderSection {
    let category: String
    let key: String
    let title: String
    let text: String
    let addImage: String
}

let reminderSections: [ReminderSection] = [
    ReminderSection(category: "Feed & Water Reminders", key: "feedWaterReminders", title: "Feed your Pet!", text: "Its time to feed your pet!", addImage: "fork.knife.circle"),
    
    ReminderSection(category: "Walk/Exercise Reminders", key: "walkExerciseReminders", title: "Walk your Pet!", text: "Its time to walk your pet!", addImage: "figure.run.circle"),
    
    ReminderSection(category: "Vet Appointment Reminders", key: "vetReminders", title: "Its time to visit vet!", text: "You have vet appointment!", addImage: "list.clipboard"),
    
    ReminderSection(category: "Medication/Vaccination Reminders", key: "medicineReminders", title: "Its time for pet to take medicine", text: "Its time for your pet to take medicine!", addImage: "pill.circle"),
    
    ReminderSection(category: "Custom Reminders", key: "customReminders", title: "Custom reminder", text: "", addImage: "square.and.pencil"),
    // Add more sections as needed
]

struct RemindersView: View {
    @State private var notificationAuth: Bool = false
    @Binding var showingProfile: Bool
    
    @State private var feedWaterReminders: [ReminderObject] = UserDefaults.standard.remindersForKey("feedWaterReminders")
    
    @State private var walkExerciseReminders: [ReminderObject] = UserDefaults.standard.remindersForKey("walkExerciseReminders")
    
    @State private var vetReminders: [ReminderObject] = UserDefaults.standard.remindersForKey("vetReminders")
    
    @State private var medicineReminders: [ReminderObject] = UserDefaults.standard.remindersForKey("medicineReminders")
    
    @State private var customReminders: [ReminderObject] = UserDefaults.standard.remindersForKey("customReminders")
    @Environment(\.scenePhase) private var scenePhase

    var notification = Notification()

    
    let backgroundGradient = LinearGradient(
        colors: [Color.green, Color.blue],
        startPoint: .top, endPoint: .bottom)
    
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                backgroundGradient.edgesIgnoringSafeArea(.all)
                Form {
                    ForEach(reminderSections, id: \.category) { section in
                        ReminderSectionView(
                            category: section.category,
                            key: section.key,
                            reminders: self.bindingForSection(section.key),
                            title: section.title,
                            text: section.text,
                            addImage: section.addImage
                        )
                    }
                }
                .accentColor(.orange)
                .background(backgroundGradient)

            }
         }
        .onAppear(perform: {
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    self.notificationAuth = true
                    print("All set!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
            
            for reminderSection in reminderSections {
                removeOldReminders(from: &bindingForSection(reminderSection.key).wrappedValue, key: reminderSection.key)
            }
            
            notification.loadPendingNotifications()

            
        })
        .navigationBarItems(leading:
            Button(action: {
                showingProfile.toggle()
            }) {
                HStack {
                    Image(systemName: "pawprint.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                }
            }
        )
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func bindingForSection(_ key: String) -> Binding<[ReminderObject]> {
        switch key {
            case "feedWaterReminders":
                return $feedWaterReminders
            case "walkExerciseReminders":
                return $walkExerciseReminders
            case "vetReminders":
                return $vetReminders
            case "medicineReminders":
                return $medicineReminders
            case "customReminders":
                return $customReminders
            // Add more cases for other sections as needed
            default:
                fatalError("Invalid section key")
            }
    }
    
    func removeOldReminders(from reminders: inout [ReminderObject], key:String) {
        let currentDate = Date()
        
        // Assuming 'reminders' is an array of ReminderObject
        let oldReminders = reminders.filter {
            if let reminderDate = $0.date {
                return reminderDate < currentDate
            } else {
                return false // Handle the case where date is nil (not set) as needed
            }
        }

        // Remove old reminders from the list
        reminders.removeAll { reminder in
            if let reminderDate = reminder.date {
                return reminderDate < currentDate && !reminder.isRecuring
            } else {
                return false // Handle the case where date is nil (not set) as needed
            }
        }
        // Update your storage (e.g., UserDefaults or a database) with the modified list
        UserDefaults.standard.setReminders(reminders, forKey: key)
        
        // You can also remove any associated notifications for the old reminders here
        for reminder in oldReminders {
            if(!reminder.isRecuring){
                notification.removeNotification(withUUID: reminder.id)
            }
        }
        // reset badge
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

}



struct RemindersView_Previews: PreviewProvider {
    @State static var showingProfile = false
  
    static var previews: some View {
        RemindersView(showingProfile: $showingProfile)
    }
}
