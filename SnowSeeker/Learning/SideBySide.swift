//
//  SideBySide.swift
//  SnowSeeker
//
//  Created by RqwerKnot on 28/04/2022.
//

import SwiftUI

/*
 However, what you see when that runs depends on several factors. If you’re using an iPhone in portrait then you’ll see the layout you’ve come to expect: a large “Primary” title at the top, then a small “Hello, world!” centered in the space below.

 If you rotate that same phone to landscape, then you’ll see one of two things: on the majority of iPhones the navigation title will shrink away to small text so that it takes up less space, but on max-sized iPhones, such as the iPhone 13 Pro Max, you’ll see that our title becomes a blue button in the top-left corner, leaving the whole rest of the screen clear. Tapping that button makes the “Hello, world!” text slide in from the leading edge, where you’ll also see the “Primary” title at the top.

 On iPad things get even clever, because the system will select from three different layouts depending on the device’s size and the available screen space. For example, if we were using a 12.9-inch iPad Pro in landscape, then:

     If our app has the whole screen to itself, you’ll see the “Hello, world!” view visible on the left, with nothing on the right.
     If the app has very little space, it will look just like a long iPhone in portrait.
     For other sizes, you’re likely to see the “Primary” button visible, which causes the “Hello, world!” text to slide in when pressed.

 What you’re seeing here is called adaptive layout, and it’s used in many of Apple’s apps such as Notes, Mail, and more. It allows iOS to make best use of available screen space without us needing to get involved.

 What’s actually happening here is that iOS is giving us a primary/secondary layout: a primary view to act as navigation, such as selecting from a list of books we’ve read or a list of Apollo missions, and a secondary view to act as further information, such as more details about a book or Apollo mission selected in the primary view.
 */

struct SideBySide: View {
    var body: some View {
        // In our trivial code example, SwiftUI interprets the single view inside our NavigationView as being the primary view in this primary/secondary layout. However, if we do provide two views then we get some really useful behavior out of the box:
        NavigationView {
            NavigationLink {
                Text("new secondary")
            } label: {
                Text("Hello World")
            }
            .navigationTitle("Primary")


            Text("Secondary")
        }
    }
    // SwiftUI automatically links the primary and secondary views, which means if you have a NavigationLink in the primary view it will automatically load its content in the secondary view:
}

/*
 However, right now at least, all this magic has a few drawbacks that I hope will be fixed in a future SwiftUI update:

     Detail views always get a navigation bar whether you want it or not, so you need to use navigationBarHidden(true) to hide it.
     There’s no way of making the primary view stay visible even when there is more than enough space.
     You can’t make the primary view shown in landscape by default; SwiftUI always chooses the detail.

 Tip: You can even add a third view to NavigationView, which lets you create a sidebar. You’ll see these in apps such as Notes, where you can navigate up from from the list of notes to browse note folders. So, navigation links in the first view control the second view, and navigation links in the second view control the third view – it’s an extra level of organization for times when you need it.
 */

struct SideBySide_Previews: PreviewProvider {
    static var previews: some View {
        SideBySide()
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDevice("iPhone 13 Pro Max")
    }
}
