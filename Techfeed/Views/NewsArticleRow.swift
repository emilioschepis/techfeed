//
//  NewsArticleRow.swift
//  Techfeed
//
//  Created by Emilio Schepis on 14/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct NewsArticleRow : View {
    var newsArticle: NewsArticle
    
    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        return formatter
    }()
    
    init(_ newsArticle: NewsArticle) {
        self.newsArticle = newsArticle
    }
    
    var body: some View {
        NavigationButton(destination: NewsArticleDetailPage(newsArticle)) {
            VStack(alignment: .leading) {
                Text(newsArticle.title)
                    .font(.headline)
                Text("\(newsArticle.date, formatter: formatter)")
                    .font(.subheadline)
                    .color(.secondary)
            }
        }
        .frame(height: 44.0)
    }
}

#if DEBUG
struct NewsArticleRow_Previews : PreviewProvider {
    static let newsArticle = NewsArticle(id: "1", title: "Test title", description: "Test description", date: Date(), link: URL(string: "https://example.com/")!)
    
    static var previews: some View {
        NewsArticleRow(newsArticle)
            .previewLayout(.sizeThatFits)
    }
}
#endif
