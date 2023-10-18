//
//  ContentView.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 16.09.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("profileCreated") private var profileCreated: Bool = false
    @State private var showingProfile = false

    
    var body: some View {
        NavigationView {
            ZStack {
                if showingProfile || !profileCreated {
                    if profileCreated {
                        ProfileCompletedView(showingProfile: $showingProfile)
                    } else {
                        ProfileEditView()
                    }
                } else {
                    RemindersView(showingProfile: $showingProfile)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Use stack navigation style on iPad
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
