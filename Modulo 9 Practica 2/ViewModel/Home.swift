//
//  Home.swift
//  Modulo 9 Practica 2
//
//  Created by Desarrollo on 16/07/24.
//

import Foundation

class Home: ObservableObject {
    @Published var loading: Bool = false
    @Published var drinks: [Drink] = []
    @Published var errorSaving: Error? = nil
    @Published var noInternet = false
    
    private let fm = FileManager.default
    private let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        .appendingPathComponent(Constants.fileName, conformingTo: .archive)
    private let imageUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private var internetMonitor = InternetMonitor()
    
    init() {
        loading = true
        if !fm.fileExists(atPath: fileUrl.path()) {
            if internetMonitor.isConnected {
                if let url = URL(string: Constants.basePath + Constants.fileName) {
                    let request = URLRequest(url: url)
                    let session = URLSession(configuration: .ephemeral)
                    let task = session.dataTask(with: request) { data, response, error in
                        if error == nil {
                            do {
                                try data?.write(to: self.fileUrl)
                            } catch let e {
                                print(e)
                            }
                                DispatchQueue.main.async {
                                    self.loading = false
                                    self.readFile()
                                    self.loading = false
                                }
                        }
                    }
                    task.resume()
                }
            } else {
                noInternet = true
            }
        } else {
            readFile()
            loading = false
        }
    }
    
    private func readFile() {
        if fm.fileExists(atPath: fileUrl.path()) {
            do {
                let data = try Data(contentsOf: fileUrl)
                drinks = try JSONDecoder().decode([Drink].self, from: data)
                downloadImages()
            } catch let error {
                print(error)
            }
        }
    }
    
    private func downloadImages() {
        if !drinks.isEmpty {
            for drink in drinks {
                let imageLocal = imageUrl.appendingPathComponent(drink.img, conformingTo: .image)
                if !fm.fileExists(atPath: imageLocal.path()), let url = URL(string: Constants.basePath + Constants.imagePath + drink.img) {
                    let request = URLRequest(url: url)
                    let session = URLSession(configuration: .ephemeral)
                    let task = session.dataTask(with: request) { data, response, error in
                        if error == nil {
                            do {
                                try data?.write(to: imageLocal)
                            } catch let error {
                                print(error)
                            }
                        }
                    }
                    task.resume()
                }
            }
        }
    }
    
    func save(drink: Drink, imageData: Data?) {
        
        do {
            if let data = imageData {
                try data.write(to: imageUrl.appendingPathComponent(drink.img, conformingTo: .image))
            }
            drinks.append(drink)
            let json = try JSONEncoder().encode(drinks)
            try json.write(to: fileUrl)
        } catch let error {
            errorSaving = error
            print(error)
        }
        
        
    }
}
