//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by RqwerKnot on 31/01/2022.
//

import Foundation

extension Bundle {
    
    // using Generics: generic types (T) to leverage and reuse code
    // T must be Decodable in this case because of decode() method from JSONDecoder that requires so
    func decode<T: Codable>(_ file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "y-MM-dd"
////        formatter.timeZone = .current // most of the time, timezone must be set so that there is no confusion between the timezone of the data source and the timezone of the user's device the app wil be working on
//        // here we can forget about it because the data source is a local file in the bundle on the user's device and the date will be shown on the same device
//
//        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return decoded
    }
}
