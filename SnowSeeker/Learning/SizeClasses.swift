//
//  SizeClasses.swift
//  SnowSeeker
//
//  Created by RqwerKnot on 28/04/2022.
//

import SwiftUI

/*
 You might wonder how often you need to have alternative layouts like this, but the answer might surprise you: it’s really common! You see, this is exactly what you want to happen when trying to write code that works across multiple device sizes – if we want layout to happen vertically when horizontal space is constrained, but horizontally otherwise. Apple provides a very simple solution called size classes, which is a thoroughly vague way of telling us how much space we have for our views.

 When I say “thoroughly vague” I mean it: we have only two size classes horizontally and vertically, called “compact” and “regular”. That’s it – that covers all screen sizes from the largest iPad Pro in landscape down to the smallest iPhone in portrait. That doesn’t mean it’s useless – far from it! – just that it only lets us reason about our user interfaces in the broadest terms.

 To demonstrate size classes in action, we could create a view that has a property to track the current size class so we can switch between VStack and HStack automatically:
 */
struct SizeClasses: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack(content: UserView.init)
        }
        // What you see when that code runs depends on the device you’re using. For example, an iPhone 13 Pro will have a compact horizontal size class in both portrait and landscape, whereas an iPhone 13 Pro Max will have a regular horizontal size class when in landscape.
    }
    // Tip: In situations like this, where you have only one view inside a stack and it doesn’t take any parameters, you can pass the view’s initializer directly to the VStack to make your code shorter
}

struct SizeClasses_Previews: PreviewProvider {
    static var previews: some View {
        SizeClasses()
    }
}
