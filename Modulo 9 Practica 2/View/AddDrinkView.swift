//
//  AddDrinkView.swift
//  Modulo 9 Practica 2
//
//  Created by Desarrollo on 17/07/24.
//

import SwiftUI

struct AddDrinkView: View {
    @ObservedObject var vm: Home
    @Environment(\.dismiss) var dismiss
    @State private var directions = ""
    @State private var ingredients = ""
    @State private var name = ""
    @State private var imageData: Data?
    //@State private var imagePicker = ImagePicker
    @State private var showCamera = false
    @State private var image: UIImage?
    @State private var cameraError: CameraPermission.CameraError?
    @State private var validationError = false
    var body: some View {
        VStack {
            
            Form {
                TextField("Name", text: $name)
                Section("Take a picture") {
                    Button {
                        if let error = CameraPermission.checkPermissions() {
                            cameraError = error
                        } else {
                            showCamera.toggle()
                        }
                    } label: {
                        if let i = image {
                            Image(uiImage: i)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150, alignment: .center)
                                .cornerRadius(5)
                        } else {
                            Image(systemName: "photo.badge.plus.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150, alignment: .center)
                                .cornerRadius(5)
                        }
                    }
                    .frame(width: 300, height: 300)
                    .alert(isPresented: .constant(cameraError != nil), error: cameraError) { _ in
                        Button("OK") { cameraError = nil}
                    } message: { error in
                        Text(error.recoverySuggestion ?? "Try again later")
                    }
                    .sheet(isPresented: $showCamera) {
                        Camera(selectedImage: $image)
                            .ignoresSafeArea()
                    }//.ignoresSafeArea()
                    
                }
                
                Section(header: Text("Ingredients")) {
                    TextField("Ingredients", text: $ingredients)
                }
                Section(header: Text("Directions")) {
                    TextField("Directions", text: $directions)
                }
            }
        }
        .onChange(of: image) {
            if let uiImage = image {
                imageData = uiImage.jpegData(compressionQuality: 1.0)
            }
        }
        .alert("Validation error", isPresented: $validationError) {
            Button("OK") { validationError = false }
        } message: {
            Text("All the fields are required, including the picture.")
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if name != "" && directions != "" && ingredients != "" && image != nil {
                        vm.save(drink: Drink(directions: directions, ingredients: ingredients, name: name, img: "\(vm.drinks.count + 1).jpg"), imageData: imageData)
                        dismiss()
                    } else {
                        validationError = true
                    }
                    
                } label: {
                    Text("Save")
                }
            }
        }
        //.navigationTitle("Title")
    }
}

#Preview {
    AddDrinkView(vm: Home())
}
