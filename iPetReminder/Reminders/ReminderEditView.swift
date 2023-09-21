//
//  ReminderEditView.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 20.09.2023.
//

import SwiftUI

struct ReminderEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var date = Date()

    @State private var minute = 0  // Minutes (0 - 59)
    @State private var dayOfWeek = 0  // Day of week (0 - 6)
    @State private var dayOfMonth = 1  // Day of month (1 - 31)
    @State private var month = 1  // Month (1 - 12)
    
    @State private var time = Date()  // Month (1 - 12)

    @State private var isRecurring = false
    @State private var recurrenceOption = 0
    
    @State private var reminderString = ""
    
    @State private var title:String = ""
    @State private var description:String = ""


    let recurrenceOptions = ["Hour", "Day", "Week", "Month", "Year"]
    
    let firstWeekday = Calendar.current.firstWeekday
    var weekDay: [String] {
        return firstWeekday == 1 ? weekDay1 : weekDay2
    }
    
    let weekDay1 = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    let weekDay2 = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    let months = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ]

    // Closure property to accept the add function
    let addReminder: (ReminderObject) -> Void
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Reminder Time")) {
                    Toggle(isOn: $isRecurring) {
                        Text("Recurring")
                    }
                    
                }

                Section(header: Text("Choose datetime")) {
                    

                    if isRecurring {
                        
                        Picker(selection: $recurrenceOption, label: Text("Recurrence")) {
                            ForEach(recurrenceOptions.indices, id: \.self) { index in
                                Text(self.recurrenceOptions[index]).tag(index)
                            }
                        }
                        
                        if recurrenceOption == 0 {
                            Picker("Minute", selection: $minute) {
                                ForEach(0..<60) { Text("\($0)") }
                            }
                        }
                        
                        if recurrenceOption >= 1 {
                            DatePicker("Select date time", selection: $time, displayedComponents: .hourAndMinute)
                        }
                        
                        if recurrenceOption == 2 {
                            Picker("Day of Week", selection: $dayOfWeek) {
                                ForEach(0..<7) {
                                    Text(weekDay[$0])
                                }
                            }
                        }
                        
                        if recurrenceOption >= 3 {
                            Picker("Day of Month", selection: $dayOfMonth) {
                                ForEach(1..<32) {
                                    Text("\($0)")
                                }
                            }
                        }
                        
                        if recurrenceOption >= 4 {
                            Picker("Month", selection: $month) {
                                ForEach(1..<13) {
                                    Text("\($0)")
                                }
                            }
                        }
                    }else{
                        Section(header: Text("Select date time")) {
                                            DatePicker("Select date time", selection: $date,
                                                       in: Calendar.current.date(byAdding: .day, value: 0, to: Date())!...
                                            )
                                            .datePickerStyle(.automatic)
                                        }
                    }
                }
                
                Section(header: Text("Title & description(optional)")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
                
                Button(action: {
                    
                    var components = DateComponents()
                    
                    components.timeZone = TimeZone.current
                    
                    if isRecurring {
                        let current = Calendar.current
                        let hour = current.component(.hour, from: time)
                        let updateMinute = recurrenceOption == 0 ? minute : current.component(.minute, from: time)
                        
                        switch recurrenceOptions[recurrenceOption] {
                        case "Hour":
                            components.minute = minute
                        case "Day":
                            components.hour = hour
                            components.minute = updateMinute
                        case "Week":
                            components.hour = hour
                            components.minute = updateMinute
                            components.weekday = dayOfWeek + 1
                        case "Month":
                            components.hour = hour
                            components.minute = updateMinute
                            components.day = dayOfMonth+1
                        case "Year":
                            components.hour = hour
                            components.minute = updateMinute
                            components.day = dayOfMonth+1
                            components.month = month+1
                        default:
                            return
                        }
                        reminderString = "Every"
                        if(recurrenceOption==0){
                            reminderString = "\(reminderString) \(recurrenceOptions[recurrenceOption]) at \(minute) minute"
                        }
                        if(recurrenceOption==1){
                            reminderString = "\(reminderString) \(recurrenceOptions[recurrenceOption])"
                        }
                        
                        if(recurrenceOption==2){
                            reminderString = "\(reminderString) \(weekDay[dayOfWeek])"
                        }
                        
                        if(recurrenceOption==3){
                            reminderString = "\(reminderString) Month, \(dayOfMonth)"
                        }
                        
                        if(recurrenceOption==4){
                            reminderString = "\(reminderString) \(months[month])"
                        }
                        
                        if(recurrenceOption>=1){
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeStyle = .short

                            // Set the locale to use the user's current locale for time formatting
                            dateFormatter.locale = Locale.current

                            let timeString = dateFormatter.string(from: time)
                            
                            reminderString = "\(reminderString), \(timeString)"
                        }
                    } else {
                        reminderString = "At \(date)"
                    }
                    

                    let newReminder = ReminderObject(id: UUID(), reminderString: reminderString, isRecuring: isRecurring, date: date, dateComponent: components, title: title, description: description)

                
                    addReminder(newReminder)
                    // Dismiss the view
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Reminder")
                    }
                }
            }
        }
        .navigationBarTitle("Set Reminder", displayMode: .inline)
    }
}


struct ReminderEditView_Previews: PreviewProvider {

    
    var reminderObject =  ReminderObject(id:UUID(), reminderString: "test date", isRecuring:false,  date: Date(), dateComponent: DateComponents(), title:"title", description: "description")
    
    static func add(newReminder:ReminderObject){
        print("Reminder added")
    }
    
    static var previews: some View {
        ReminderEditView(addReminder: add)
    }
}
