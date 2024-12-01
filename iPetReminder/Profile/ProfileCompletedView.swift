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
        VStack(spacing: 0) {
            Header()
            
            ScrollView {
                VStack(spacing: 25) {
                    ProfileText()
                    
                    NavigationLink(destination: ProfileEditView()) {
                        Label("Edit Profile", systemImage: "pencil")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 12)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(25)
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        profileCreated = false
                    })
                }
                .padding(.top, 60)
                .padding(.bottom)
            }
        }
        .navigationBarItems(leading:
            Button(action: {
                showingProfile.toggle()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Reminders")
                }
                .foregroundColor(.blue)
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
            VStack(spacing: 8) {
                Text(petName)
                    .font(.title)
                    .fontWeight(.bold)
                Text(petType)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}



struct ProfileCompletedView_Previews: PreviewProvider {
    @State static var showingProfile = true

    static var previews: some View {
        ProfileCompletedView(showingProfile: $showingProfile)
    }
}
