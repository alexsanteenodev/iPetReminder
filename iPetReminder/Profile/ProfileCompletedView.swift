//
//  ProfileCompletedView.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 16.09.2023.
//

import SwiftUI

struct ProfileCompletedView: View {
    @AppStorage("petName") private var petName: String = ""
    @AppStorage("petType") private var petType: String = ""
    @AppStorage("profileCreated") private var profileCreated: Bool = false
    @Binding var showingProfile: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Profile Completed")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Pet Name: \(petName)")
                .font(.title2)

            Text("Pet Type: \(petType)")
                .font(.title2)

            NavigationLink(destination: PetProfileView()) {
                Text("Edit Profile")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .simultaneousGesture(TapGesture().onEnded{
                profileCreated = false
            })
            
            .navigationBarItems(leading:
                Button(action: {
                    showingProfile.toggle()
                }) {
                    HStack {
                        Text("Reminders")
                    }
                }
            )
        }
        .padding()
    }
}

struct ProfileCompletedView_Previews: PreviewProvider {
    @State static var showingProfile = true

    static var previews: some View {
        ProfileCompletedView(showingProfile: $showingProfile)
    }
}
