//
//  Resort.swift
//  SnowSeeker
//
//  Created by RqwerKnot on 28/04/2022.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    //The next step is to create Facility instances for every of the facilities in a Resort, which we can do in a computed property inside the Resort struct itself:
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
}

/*
 As usual, it’s a good idea to add an example value to your model so that it’s easier to show working data in your designs. This time, though, there are quite a few fields to work with and it’s helpful if they have real data, so I don’t really want to create one by hand.
 */

extension Resort {
    // One static let property can reference another in the same type. Be careful not to make a reference chain by accident, because it can cause your code to crash.
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    // static let properties are always created lazily. This means they are only initialized when first accessed
    
    // alternatively:
    //static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
    
    /*
     In case you were curious, when we use static let for properties, Swift automatically makes them lazy – they don’t get created until they are used. This means when we try to read Resort.example Swift will be forced to create Resort.allResorts first, then send back the first item in that array for Resort.example. This means we can always be sure the two properties will be run in the correct order – there’s no chance of example going missing because allResorts wasn’t called yet.
     */
}
