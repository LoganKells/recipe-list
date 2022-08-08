//
//  RecipeDetailView.swift
//  recipe-list
//
//  Created by Logan Kells on 8/8/22.
//

import SwiftUI

struct RecipeDetailView: View {
    // This view updates when the activeRecipe updates.
    var activeRecipe: Recipe
    
    // MARK: Recipe Detailed View
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading){
                Image(activeRecipe.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 200, idealWidth: 400, maxWidth: 500, minHeight: 200, idealHeight: 300, maxHeight: 400, alignment: .center)
                    .clipped()
                    .cornerRadius(10)
                
                // MARK: Ingredients List
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.title)
                        .padding(.vertical, 1.0)
                    ForEach(0..<activeRecipe.ingredients.count, id: \.self) { i in
                        HStack(alignment: .top) {
                            Text("\(i + 1).")
                                .fontWeight(.semibold)
                            Text(activeRecipe.ingredients[i])
                                .padding(.leading, 1.0)
                        }
                    }.padding(.bottom, 1.0)
                }.padding(.bottom, 5.0)

                
                // MARK: Directions List
                VStack(alignment: .leading) {
                    Text("Directions")
                        .font(.title)
                        .padding(.vertical, 1.0)
                    ForEach(0..<activeRecipe.directions.count, id: \.self) { i in
                        HStack(alignment: .top) {
                            Text("Step \(i + 1):")
                                .fontWeight(.semibold)
                            Text(activeRecipe.directions[i])
                                .padding(.leading, 1.0)
                        }
                    }.padding(.bottom, 1.0)
                }.padding(.bottom, 5.0)
            }.padding(.horizontal)
            
        }.navigationBarTitle(activeRecipe.name)
            .navigationBarTitleDisplayMode(
                NavigationBarItem.TitleDisplayMode.large)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        // Build dummy
        let model = RecipeViewModel()
        
        
        RecipeDetailView(activeRecipe: model.recipes[0])
    }
}
