//
//  RecipeModel.swift
//  recipe-list
//
//  Created by Logan Kells on 8/1/22.
//

import Foundation

enum FileError: Error {
    // See https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html
    case invalidSelection(fileName: String, fileType: String)
    case readError(url: URL)
    case decodeError(url: URL)
}

class RecipeViewModel: ObservableObject {
    // Update the View using the [Recipe] data.
    @Published var recipes: [Recipe]?
    
    private func getFileUrl(fileName: String, fileType: String, directory: String = "resources") throws -> URL {
        // Import data from the ./resources/recipes.json file

        let url: URL?
        
        if let filePath: String = Bundle.main.path(forResource: fileName, ofType: fileType) {
            url = URL(fileURLWithPath: filePath)
        } else {
            url = nil
            throw FileError.invalidSelection(fileName: fileName, fileType: fileType)
        }
        return url!
    }
    
    private func decodeJson(url: URL) throws -> [Recipe]? {
        let decoder: JSONDecoder = JSONDecoder()
        let recipeByteData: Data?
        let recipeData: [Recipe]?
        do {
            recipeByteData = try Data(contentsOf: url)
        } catch {
            recipeByteData = nil
            throw FileError.readError(url: url)
        }
        
        // Decode the byte data into a [Recipe] array.
        do {
            recipeData = try decoder.decode([Recipe].self, from: recipeByteData!)
        } catch {
            recipeData = nil
            throw FileError.decodeError(url: url)
        }
        return recipeData
    }
    
    init() {
        // Get a URL to the json file
        let fileName: String = "recipes"
        let fileType: String = "json"
        let fileUrl: URL?
        let data: Data?
        let recipeData: [Recipe]?
        let decoder: JSONDecoder = JSONDecoder()
        
        // Get a URL to the json file
        do {
            fileUrl = try getFileUrl(fileName: fileName, fileType: fileType)
        } catch {
            fileUrl = nil
            print("Error, file \"\(fileName).\(fileType)\" not found.\n\(error)")
        }
        
        // Decode the data from the json
        do {
            recipeData = try decodeJson(url: fileUrl!)
        } catch {
            recipeData = nil
            print("Error decoding file.\n\(error)")
        }
        
        for recipe in recipeData! {
            recipe.id = UUID()
        }
        
        self.recipes = recipeData
    }
}
