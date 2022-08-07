//
//  ContentView.swift
//  recipe-list
//
//  Created by Logan Kells on 8/1/22.
//

import SwiftUI

struct ContentView: View {
    // View Model
    @ObservedObject var viewModel = RecipeViewModel()  // Listen to object for published changes
    
    var body: some View {
        List(viewModel.recipes) { recipe in
            
            HStack(spacing: 18.0){
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 55, height: 55, alignment: .center)
                    .clipped()
                    .cornerRadius(6)
                Text(recipe.name)
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
