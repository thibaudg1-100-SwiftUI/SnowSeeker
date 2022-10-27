//
//  AlertIdentifiable.swift
//  SnowSeeker
//
//  Created by RqwerKnot on 28/04/2022.
//

import SwiftUI

/*
 The second option allows us to bind an optional to the alert or sheet, and we used it briefly when presenting map pins. If you remember, the key is that we use an optional Identifiable object as the condition for showing the sheet, and the closure hands you the non-optional value that was used for the condition, so you can use it safely.
 */

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct AlertIdentifiable: View {
    
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                selectedUser = User()
                isShowingUser = true
            }
        // a sheet using only the optional value as a trigger:
//            .sheet(item: $selectedUser) { user in
//                Text(user.id)
//            }
            // an alert requires both the optional data that is gonna be unwrapped on our behalf and a Boolean to trigger the alert
            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
                Button(user.id) { }
            }
        
            // for very simple alerts, SwiftUI automatically adds a "OK" button that dismisses the alert:
//            .alert("Welcome", isPresented: $isShowingUser) { }
    }
}

struct AlertIdentifiable_Previews: PreviewProvider {
    static var previews: some View {
        AlertIdentifiable()
    }
}
