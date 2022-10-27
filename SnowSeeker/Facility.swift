//
//  Facility.swift
//  SnowSeeker
//
//  Created by RqwerKnot on 29/04/2022.
//

import SwiftUI

struct Facility: Identifiable {
    
    // As you can see, that conforms to Identifiable so we can loop over an array of facilities with SwiftUI, and internally it looks up a given facility name in a dictionary to return the correct icon. I’ve picked out various SF Symbols icons that work well for the facilities we have, and I also used an accessibilityLabel() modifier for the image to make sure it works well in VoiceOver.
    let id = UUID()
    var name: String

    private let icons = [
        "Accommodation": "house",
        "Beginners": "1.circle",
        "Cross-country": "map",
        "Eco-friendly": "leaf.arrow.circlepath",
        "Family": "person.3"
    ]

    var icon: some View {
        if let iconName = icons[name] {
            return Image(systemName: iconName)
                .accessibilityLabel(name)
                .foregroundColor(.secondary)
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }
    
    private let descriptions = [
        "Accommodation": "This resort has popular on-site accommodation.",
        "Beginners": "This resort has lots of ski schools.",
        "Cross-country": "This resort has many cross-country ski routes.",
        "Eco-friendly": "This resort has won an award for environmental friendliness.",
        "Family": "This resort is popular with families."
    ]
    
    var description: String {
        if let message = descriptions[name] {
            return message
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }
}
