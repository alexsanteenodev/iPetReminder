//
//  Header.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 30.09.2023.
//

import SwiftUI

struct Header: View {
    @AppStorage("profileImage") private var profileImageData: Data?

    var body: some View {
        ZStack(alignment: .top) {
                
            
            Rectangle()
                .foregroundColor(Color.white)
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 100)
            
            if let data = profileImageData,
                          let uiImage = UIImage(data: data) {
                           Image(uiImage: uiImage)
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 150, height: 150)
                               .clipShape(Circle())
                       } else {
                           Image(systemName: "person.circle.fill")
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 150, height: 150)
                               .clipShape(Circle())
                       }
        }
    }
}
