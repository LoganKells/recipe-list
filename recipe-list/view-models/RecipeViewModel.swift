//
//  RecipeModel.swift
//  recipe-list
//
//  Created by Logan Kells on 8/1/22.
//

import Foundation



/// The ViewModel handles the business logic for the application.
class RecipeViewModel: ObservableObject {
    // Update the View using the [Recipe] data.
    @Published var recipes: [Recipe]?
    
    // The data service contains helper methods for reading
    // data from storage.
    let dataService: DataService = DataService()
    
    /// The main purpose of the init in the ViewModel is to load data from storage to
    /// the @Published var recipes variable.
    init() {
        let fileName: String = "recipes"
        let fileType: String = "json"
        
        // Create a [Recipe] array by reading data from json storage.
        self.recipes = DataService().readData(fileName: fileName, fileType: fileType)
    }
}
