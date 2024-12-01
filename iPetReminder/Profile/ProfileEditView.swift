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
                Section {
                    VStack(alignment: .center, spacing: 20) {
                        if image.size.width > 0 {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 2))
                        } else if let data = profileImageData, let profileImage = UIImage(data: data) {
                            Image(uiImage: profileImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 2))
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .foregroundColor(.gray)
                        }
                        
                        HStack(spacing: 20) {
                            Button {
                                isCameraPickerPresented = true
                                isGalleryPickerPresented = false
                            } label: {
                                Label("Camera", systemImage: "camera")
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            
                            Button {
                                isGalleryPickerPresented = true
                                isCameraPickerPresented = false
                            } label: {
                                Label("Gallery", systemImage: "photo")
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                }
                
                Section(header: Text("Pet Details")) {
                    TextField("Pet Name", text: $petName)
                    TextField("Pet Type/Breed", text: $petType)
                }
                
                Section(header: Text("About")) {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isCameraPickerPresented) {
                ImagePicker(sourceType: .camera, selectedImage: $image)
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $isGalleryPickerPresented) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
                    .ignoresSafeArea()
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
