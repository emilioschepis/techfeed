//
//  ReleasesSource.swift
//  Techfeed
//
//  Created by Emilio Schepis on 15/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Combine
import SwiftUI

class ReleasesSource: BindableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    var releases = [Release]()
    let parser = ReleasesParser()
    
    init() {
        fetch()
    }
    
    func fetch() {
        let url = URL(string: "https://developer.apple.com/news/releases/rss/releases.rss")!
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else {
                self?.releases = []
                self?.didChange.send(())
                return
            }
            
            self?.parser.parse(data: data) { releases in
                self?.releases = releases.sorted(by: >)
                
                DispatchQueue.main.async {
                    self?.didChange.send(())
                }
            }
        }.resume()
    }
}
