//
//  PetProfileView.swift
//  iPetReminder
//
//  Created by Oleksandr Hanhaliuk on 16.09.2023.
//

import SwiftUI
import UIKit

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.bounds.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}


struct ProfileEditView: View {
    @AppStorage("petName") private var petName = ""
    @AppStorage("petType") private var petType = ""
    @AppStorage("description") private var description = "Describe your pet"

    @AppStorage("profileCreated") private var profileCreated: Bool = false
    @AppStorage("profileImage") private var profileImageData: Data?

    
    @State private var image = UIImage()
    @State private var isCameraPickerPresented: Bool = false
    @State private var isGalleryPickerPresented: Bool = false

    
    var body: some View {
        NavigationView {
                        Form {
                            Section(header: Text("Pet Information")) {
                                Button("Take Photo") {
                                            isCameraPickerPresented.toggle()
                                        }
                                        .padding()
                                        .sheet(isPresented: $isCameraPickerPresented) {
                                            ImagePicker(sourceType: .camera, selectedImage: self.$image)
                                        }

                            Button("Choose from Gallery") {
                                            isGalleryPickerPresented.toggle()
                                        }
                                        .padding()
                                        .sheet(isPresented: $isGalleryPickerPresented) {
                                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                                            
                                        }
                                

    
                                
                                if image.size.width > 0 && image.size.height > 0 {
                                    Image(uiImage: image) // Display the default image if profileImageData is nil
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 150)
                                        .padding()
                                } else if let data = profileImageData, let profileImage = UIImage(data: data) {
                                    Image(uiImage: profileImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 150)
                                        .padding()
                                }
                                
                                TextField("Pet Name", text: $petName)
                                TextField("Pet Type/Breed", text: $petType)
                                TextEditor(text: $description)
                            }
                        }
        }
        .onAppear {
                    if let data = image.jpegData(compressionQuality: 0.8) {
                        // Save the image data to AppStorage
                        profileImageData = data
                    }
                }
        .navigationBarItems(
            trailing:
                Button (
                    action: {
                        if let data = image.jpegData(compressionQuality: 0.8) {
                            // Save the image data to AppStorage
                            profileImageData = data
                        }
                        profileCreated = true
                    },
                    label: {
                        Text("Done")
                    }
                )
        )
        .navigationViewStyle(StackNavigationViewStyle()) 
    }
    

}
struct ProfileEditView_Previews: PreviewProvider {

    static var previews: some View {
        ProfileEditView()
    }
}
