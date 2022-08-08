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
        NavigationView {
            List(viewModel.recipes) { recipe in
                
                NavigationLink(destination: RecipeDetailView(activeRecipe: recipe)) {
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
            }.navigationBarTitle("All Recipes")
                .navigationBarTitleDisplayMode(
                    NavigationBarItem.TitleDisplayMode.large)
            
        // NOTE - https://stackoverflow.com/a/66299785 solves error encountered when adding the .navigationBarTitle modifier to the List.
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
