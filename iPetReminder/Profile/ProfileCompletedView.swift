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
    @AppStorage("profileImage") private var profileImageData: Data?
    
    @Binding var showingProfile: Bool
    
    var body: some View {
        VStack() {
            VStack {
                Header()
                ProfileText()
            }
            Spacer()
            NavigationLink(destination: ProfileEditView()) {
                Label("Edit", systemImage: "pencil")
                    .padding()
                    .foregroundColor(.blue)
                    .cornerRadius(10)
            }
            .simultaneousGesture(TapGesture().onEnded{
                profileCreated = false
            })
        }
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
}

struct ProfileText: View {
    @AppStorage("petName") private var petName: String = ""
    @AppStorage("petType") private var petType: String = ""
    @AppStorage("description") private var description: String = ""

    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 5) {
                Text(petName)
                    .bold()
                    .font(.title)
                Text(petType)
                    .font(.body)
                    .foregroundColor(.secondary)
            }.padding()
            Text(description)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}



struct ProfileCompletedView_Previews: PreviewProvider {
    @State static var showingProfile = true

    static var previews: some View {
        ProfileCompletedView(showingProfile: $showingProfile)
    }
}
