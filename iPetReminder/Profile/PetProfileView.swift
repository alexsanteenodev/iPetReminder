//
//  PetProfileView.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 16.09.2023.
//

import SwiftUI


struct PetProfileView: View {
    @AppStorage("petName") private var petName = ""
    @AppStorage("petType") private var petType = ""
    @AppStorage("profileCreated") private var profileCreated: Bool = false
    let backgroundGradient = LinearGradient(
        colors: [Color.green, Color.blue],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        NavigationView {
                        Form {
                            Section(header: Text("Pet Information")) {
                                TextField("Pet Name", text: $petName)
                                TextField("Pet Type/Breed", text: $petType)
                                Button(action: {
                                    // information is automatically saved thanks to @AppStorage wrapper
            
            
                                    profileCreated = true
            
            
                                    print("profileCreated")
                                    print(profileCreated)
            
                                    print("Pet profile saved.")
                                }) {
                                    Text("Save Pet Profile")
                                }
                            }
                        }
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()
                VStack {
                    Text("Welcome")
                        .font(.title)
                    HStack {
                        TextField("Pet Name", text: $petName)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    HStack {
                        TextField("Pet Type/Breed", text: $petType)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    HStack {
                        Button(action: {
                            // information is automatically saved thanks to @AppStorage wrapper
                            profileCreated = true
                            print("Pet profile saved.")
                        }) {
                            Text("Save Pet Profile")
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
