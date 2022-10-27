//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by RqwerKnot on 28/04/2022.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            VStack {
                Text("Elevation")
                    .font(.caption.bold())
                Text("\(resort.elevation)m")
                    .font(.title3)
            }
            
            VStack {
                Text("Snow")
                    .font(.caption.bold())
                Text("\(resort.snowDepth)cm")
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
        // Giving the Group view a maximum frame width of .infinity doesn’t actually affect the group itself, because it has no impact on layout. However, it does get passed down to its child views, which means they will automatically spread out horizontally.
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: Resort.example)
    }
}
