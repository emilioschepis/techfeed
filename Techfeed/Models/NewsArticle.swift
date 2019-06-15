//
//  NewsArticle.swift
//  Techfeed
//
//  Created by Emilio Schepis on 14/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct NewsArticle: Identifiable, Comparable {
    var id: String
    var title: String
    var description: String
    var date: Date
    var link: URL
    
    static func < (lhs: NewsArticle, rhs: NewsArticle) -> Bool {
        return lhs.date.compare(rhs.date) == .orderedAscending
    }
}
