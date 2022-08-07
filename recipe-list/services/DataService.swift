//
//  DataService.swift
//  recipe-list
//
//  Created by Logan Kells on 8/7/22.
//

import Foundation


// File errors corresponding to the DataService.
enum FileError: Error {
    // See https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html
    case invalidSelection(fileName: String, fileType: String)
    case readError(url: URL)
    case decodeError(url: URL)
}

class DataService {
    /// Given a fileName and fileType, get a URL to the file.
    /// This function will return a URL or throw an error.
    private func getFileUrl(fileName: String, fileType: String, directory: String = "resources") throws -> URL {
        let url: URL
        
        if let filePath: String = Bundle.main.path(forResource: fileName, ofType: fileType) {
            url = URL(fileURLWithPath: filePath)
        } else {
            throw FileError.invalidSelection(fileName: fileName, fileType: fileType)
        }
        return url
    }
    
    /// Given a valid URL to a json file, this function will read the contents
    /// into a [Recipe] array.
    /// This function will return [Recipe] or throw an error.
    private func decodeJson(url: URL) throws -> [Recipe] {
        let decoder: JSONDecoder = JSONDecoder()
        let byteData: Data?
        let recipeData: [Recipe]
        
        // Read the json contents as bytes.
        do {
            byteData = try Data(contentsOf: url)
        } catch {
            byteData = nil
            throw FileError.readError(url: url)
        }
        
        // Decode the byte data into a [Recipe] array.
        do {
            recipeData = try decoder.decode([Recipe].self, from: byteData!)
        } catch {
            // recipeData = nil
            throw FileError.decodeError(url: url)
        }
        
        // Add a unique identifier for each item in the recipe
        // array, [Recipe].
        for recipe in recipeData {
            recipe.id = UUID()
        }
        
        return recipeData
    }
    
    /// This method will read data from the json storage and create a [Recipe] array.
    /// On error, this function will return an empty [Recipe] array to prevent app crash.
    public func readData(fileName: String, fileType: String) -> [Recipe] {
        let fileUrl: URL?
        let recipeData: [Recipe]
        
        // Get a URL to the json file
        do {
            fileUrl = try self.getFileUrl(fileName: fileName, fileType: fileType)
        } catch {
            fileUrl = nil
            print("Error, file \"\(fileName).\(fileType)\" not found.\n\(error)")
            return [Recipe]()
        }
        
        // Decode the data from the json
        do {
            recipeData = try self.decodeJson(url: fileUrl!)
            return recipeData

        } catch {
            print("Error decoding file.\n\(error)")
            return [Recipe]()
        }
    }
}
