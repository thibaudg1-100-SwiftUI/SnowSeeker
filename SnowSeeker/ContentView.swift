//
//  ContentView.swift
//  SnowSeeker
//
//  Created by RqwerKnot on 28/04/2022.
//

import SwiftUI

// However, we can stop iPhones from using the slide over approach if that’s what you want – try it first and see what you think.
extension View {
    // We need to use the @ViewBuilder attribute here because the two returned view types are different.
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            // this will force classic stack navigation for all phones, including iPhone 13 Pro Max in landscape
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

// for challenge:
enum SortType {
    case none, name, country
}

struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    
    @StateObject var favorites = Favorites()
    
    // for challenge:
    @State private var sort = SortType.none
    @State private var showSortingDialog = false
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack { // if you don't specify a HStack, it will still work and be a horizontal layout by default, but will not handle properly conditional layout like below using 'if'
                        Image("\(resort.country)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
                
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            // for challenge:
            .toolbar {
                Button("Sort...") { showSortingDialog.toggle()}
            }
            
            // this is the secondary view that shows up by default on iPhone 13 Pro Max (in landscape) and iPads
            WelcomeView() // this view to help the user discover the left-hand list.
            
            // That’s enough for SwiftUI to understand exactly what we want. Try running the app on several different devices, both in portrait and landscape, to see how SwiftUI responds – on an iPhone 13 Pro you’ll see ContentView in both portrait and landscape, but on an iPhone 13 Pro Max you’ll see ContentView in portrait and WelcomeView in landscape. If you’re using an iPad, you might see several different things depending on the device orientation and whether the app has all the screen to itself as opposed to using split screen.
            
            // Up to 3 views can be added this way, but only when using NavigationView
        }
        .environmentObject(favorites)
//        .phoneOnlyStackNavigationView() // only if you want to prevent the slide-over approach on iPhone13 Pro Max
        
        // for challenge:
        .confirmationDialog("Choose a sort order", isPresented: $showSortingDialog, titleVisibility: .visible) {
            Button("Default") { sort = .none }
            Button("By name") { sort = .name }
            Button("By country") { sort = .country }
            Button("Cancel", role: .cancel) {}
        }
        

    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    // for challenge:
    var sortedResorts: [Resort] {
        switch sort {
        case .none:
            return filteredResorts
        case .name:
            return filteredResorts.sorted { $0.name < $1.name }
        case .country:
            return filteredResorts.sorted { $0.country < $1.country }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
