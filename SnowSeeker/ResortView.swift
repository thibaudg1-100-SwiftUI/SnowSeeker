//
//  ResortView.swift
//  SnowSeeker
//
//  Created by RqwerKnot on 28/04/2022.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    // Fortunately, to begin with all we care about are these two horizontal options: do we have lots of horizontal space (regular) or is space restricted (compact). If we have a regular amount of space, we’re going to keep the current HStack approach so that everything its neatly on one line, but if space is restricted we’ll ditch that and place each of the views into a VStack.
    @Environment(\.horizontalSizeClass) var sizeClass
    
    // To make this even better we can combine a check for the app’s current horizontal size class with a check for the user’s Dynamic Type setting so that we use the flat horizontal layout unless space really is tight – if the user has a compact size class and a larger Dynamic Type setting.
    @Environment(\.dynamicTypeSize) var typeSize
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    Text("Credits: \(resort.imageCredit)")
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .background(.black.opacity(0.7))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                HStack {
                    // change layout depending on environment context and device without modifying children layout
                    // it's adpative layout and the children remain neutral layout (they don't integrate the way they will be shown on screen)
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 20) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 20) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                // Before we’re done, I want to show you one useful extra technique: you can limit the range of Dynamic Type sizes supported by a particular view. For example, you might have worked hard to support as wide a range of sizes as possible, but found that anything larger than the “extra extra extra large” setting just looks bad. In that situation you can use the dynamicTypeSize() modifier on a view, like this:
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                // That’s a one-sided range, meaning that any size up to and including .xxxLarge is fine, but nothing larger. Obviously it’s best to avoid setting these limits where possible, but it’s not a problem if you use it judiciously – both TabView and NavigationView, for example, limit the size of their text labels so the UI doesn’t break.
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    //Text(resort.facilities.joined(separator: ", "))
                    // or:
//                    Text(resort.facilities, format: .list(type: .and))
//                        .padding(.vertical)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                    
                }
                .padding(.horizontal)
                
                Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                    if favorites.contains(resort) {
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }

        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        // an alert provided different content depending on an optional source of truth
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        // default 'OK' button will be provided by the system
        } message: { facility in
            Text(facility.description)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResortView(resort: Resort.example)
            // Tip: Make sure you modify your ResortView preview to inject an example Favorites object into the environment, so your SwiftUI preview carries on working. This will work fine:
                .environmentObject(Favorites())
        }
    }
}
