//
//  DrinkDetailView.swift
//  Modulo 9 Practica 2
//
//  Created by Desarrollo on 17/07/24.
//

import SwiftUI

struct DrinkDetailView: View {
    let drink: Drink
    var body: some View {
        VStack {
            if let image = drink.getUIImage() {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .cornerRadius(5)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .cornerRadius(5)
            }
            List {
                Section(header: Text("Ingredients")) {
                    Text(drink.ingredients)
                }

                Section(header: Text("Directions")) {
                    Text(drink.directions)
                }
            }
        }
        .navigationTitle(drink.name)
    }
}

#Preview {
    DrinkDetailView(drink: Drink(directions: "", ingredients: "", name: "Name", img: ""))
}
