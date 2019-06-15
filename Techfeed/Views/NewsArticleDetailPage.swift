//
//  NewsArticleDetailPage.swift
//  Techfeed
//
//  Created by Emilio Schepis on 14/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct NewsArticleDetailPage : View {
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
        VStack(alignment: .leading, spacing: 4.0) {
            Text(newsArticle.title)
                .font(.title)
                .bold()
                .lineLimit(3)
            Text("\(newsArticle.date, formatter: formatter)")
                .font(.subheadline)
                .color(.secondary)
                .lineLimit(2)
            Text(newsArticle.description)
                .lineLimit(nil)
            Button(action: openURL) {
                Text("Learn more")
            }
            Spacer()
        }
        .padding(16.0)
        .navigationBarTitle(Text("Article"), displayMode: .inline)
    }
    
    func openURL() {
        if UIApplication.shared.canOpenURL(newsArticle.link) {
            UIApplication.shared.open(newsArticle.link)
        }
    }
}

#if DEBUG
struct NewsArticleDetailPage_Previews : PreviewProvider {
    static let newsArticle = NewsArticle(id: "1", title: "Test title", description: "Test description", date: Date(), link: URL(string: "https://example.com/")!)
    
    static var previews: some View {
        NewsArticleDetailPage(newsArticle)
            .previewLayout(.device)
    }
}
#endif
