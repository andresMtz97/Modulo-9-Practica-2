//
//  DrinkView.swift
//  Modulo 9 Practica 2
//
//  Created by Desarrollo on 17/07/24.
//

import SwiftUI

struct DrinkView: View {
    let drink: Drink

    var body: some View {
        
        HStack {
            if let image = drink.getUIImage() {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(5)
                    .padding(.leading, 8)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(5)
                    .padding(.leading, 8)
            }
                  
            Text(drink.name)
              .font(.headline)
              .lineLimit(1)
            Spacer()
          }
          .padding(.vertical, 8)
    }
}

#Preview {
    DrinkView(drink: Drink(directions: "directions", ingredients: "ingredients", name: "Cuba Libre", img: "1.jpg"))
}
