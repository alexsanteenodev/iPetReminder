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
    
    let backgroundGradient = LinearGradient(
        colors: [Color.red, Color.blue],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient
                                .ignoresSafeArea()
                if showingProfile || !profileCreated {
                    if profileCreated {
                        ProfileCompletedView(showingProfile: $showingProfile)
                    } else {
                        PetProfileView()
                    }
                } else {
                    RemindersView(showingProfile: $showingProfile)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
