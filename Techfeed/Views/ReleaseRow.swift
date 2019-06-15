//
//  ReleaseRow.swift
//  Techfeed
//
//  Created by Emilio Schepis on 15/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ReleaseRow : View {
    var release: Release
    
    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        return formatter
    }()
    
    init(_ release: Release) {
        self.release = release
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(release.title)
                .font(.headline)
            Text("\(release.date, formatter: formatter)")
                .font(.subheadline)
                .color(.secondary)
        }
        .frame(height: 44.0)
    }
}

#if DEBUG
struct ReleaseRow_Previews : PreviewProvider {
    static var previews: some View {
        let release = Release(id: "1", title: "Test title", description: "Test description", date: Date())
        
        return ReleaseRow(release)
            .previewLayout(.sizeThatFits)
    }
}
#endif
