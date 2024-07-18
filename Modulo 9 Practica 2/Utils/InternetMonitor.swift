//
//  InternetMonitor.swift
//  Modulo 9 Practica 2
//
//  Created by Desarrollo on 18/07/24.
//

import Foundation
import Network

class InternetMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let monitorQueue = DispatchQueue(label: "Monitor")
    @Published var isConnected = false
    @Published var connType = "no"
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            self.connType = path.usesInterfaceType(.wifi) ? "Wifi" : "Datos celulares"
        }
        
        networkMonitor.start(queue: monitorQueue)
    }
}
