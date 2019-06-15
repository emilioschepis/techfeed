//
//  ContentView.swift
//  Techfeed
//
//  Created by Emilio Schepis on 14/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        TabbedView {
            // TODO: Add images to item labels once the SwiftUI bug is fixed
            NewsPage()
                .tabItemLabel(Text("News"))
                .tag(0)
            ReleasesPage()
                .tabItemLabel(Text("Releases"))
                .tag(1)
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
