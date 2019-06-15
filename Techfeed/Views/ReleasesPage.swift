//
//  ReleasesPage.swift
//  Techfeed
//
//  Created by Emilio Schepis on 15/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ReleasesPage : View {
    @ObjectBinding var releasesSource = ReleasesSource()
    
    var body: some View {
        let refreshBarItem = Button(action: releasesSource.fetch) {
            Image(systemName: "arrow.clockwise")
        }
        
        return NavigationView {
            List(releasesSource.releases, rowContent: ReleaseRow.init)
                .navigationBarTitle(Text("Releases"))
                .navigationBarItems(trailing: refreshBarItem)
        }
    }
}

#if DEBUG
struct ReleasesPage_Previews : PreviewProvider {
    static var previews: some View {
        ReleasesPage()
    }
}
#endif
