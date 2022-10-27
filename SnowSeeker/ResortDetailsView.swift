//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by RqwerKnot on 28/04/2022.
//

import SwiftUI

struct ResortDetailsView: View {
    
    let resort: Resort
    
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var size: String {
        // not really safe:
        //["Small", "Average", "Large"][resort.size - 1]
        
        //instead:
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("Size")
                    .font(.caption.bold())
                Text(size)
                    .font(.title3)
            }
            
            VStack {
                Text("Price")
                    .font(.caption.bold())
                Text(price)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
