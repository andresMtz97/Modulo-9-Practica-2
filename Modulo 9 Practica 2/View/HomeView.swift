//
//  ContentView.swift
//  Modulo 9 Practica 2
//
//  Created by Desarrollo on 16/07/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = Home()
        
    var body: some View {
        
        ZStack {
            NavigationView {
                List(vm.drinks, id: \.img) { drink in
                    NavigationLink(destination: DrinkDetailView(drink: drink)) {
                        DrinkView(drink: drink)
                    }
                }
                .navigationTitle("My Drinks")
                .toolbar {
                    NavigationLink(destination: AddDrinkView(vm: vm)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("Saving error", isPresented: .constant(vm.errorSaving != nil)) {
                Button("OK") { vm.errorSaving = nil }
            } message: {
                Text("An error occurred while saving the drink. Try Again Later")
                Text(vm.errorSaving?.localizedDescription ?? "")
            }
            .alert("No Internet Connection", isPresented: $vm.noInternet) {
                Button("OK") {}
            } message: {
                Text("An error occurred while saving the drink. Try Again Later")
                Text(vm.errorSaving?.localizedDescription ?? "")
            }
            if vm.loading {
                ProgressView()
            }
        }
    }
}

#Preview {
    HomeView()
}
