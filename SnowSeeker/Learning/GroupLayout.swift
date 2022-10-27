//
//  GroupLayout.swift
//  SnowSeeker
//
//  Created by RqwerKnot on 28/04/2022.
//

import SwiftUI

/*
 SwiftUI’s Group view is commonly used to work around the 10-child view limit, but it also has another important behavior: it acts as a transparent layout container. This means the group doesn’t actually affect our layout at all, but still gives us the ability to add SwiftUI modifiers as needed, or send back multiple views without using @ViewBuilder.
 */

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct GroupLayout: View {
    @State private var layoutVertically = false
    
    var body: some View {
        Group {
            if layoutVertically {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
        .onTapGesture {
            layoutVertically.toggle()
        }
    }
}

struct GroupLayout_Previews: PreviewProvider {
    static var previews: some View {
        GroupLayout()
    }
}
