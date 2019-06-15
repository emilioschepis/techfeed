//
//  Release.swift
//  Techfeed
//
//  Created by Emilio Schepis on 15/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct Release: Identifiable, Comparable {
    var id: String
    var title: String
    var description: String
    var date: Date
    
    static func < (lhs: Release, rhs: Release) -> Bool {
        return lhs.date.compare(rhs.date) == .orderedAscending
    }
}
