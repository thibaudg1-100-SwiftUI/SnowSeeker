//
//  Favorites.swift
//  SnowSeeker
//
//  Created by RqwerKnot on 29/04/2022.
//

import Foundation

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
        }
        // still here? Use an empty array
        resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        // write out our data
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(resorts){
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
}
