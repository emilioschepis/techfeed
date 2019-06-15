//
//  NewsPage.swift
//  Techfeed
//
//  Created by Emilio Schepis on 14/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI
import Combine

struct NewsPage : View {
    @ObjectBinding var newsSource = NewsSource()

    var body: some View {
        let refreshBarItem = Button(action: newsSource.fetch) {
            Image(systemName: "arrow.clockwise")
        }
        
        return NavigationView {
            List(newsSource.news, rowContent: NewsArticleRow.init)
                .navigationBarTitle(Text("News"))
                .navigationBarItems(trailing: refreshBarItem)
        }
    }
}

#if DEBUG
struct NewsPage_Previews : PreviewProvider {
    static var previews: some View {
        NewsPage()
    }
}
#endif
