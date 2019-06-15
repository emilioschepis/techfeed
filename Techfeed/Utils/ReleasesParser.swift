//
//  ReleasesParser.swift
//  Techfeed
//
//  Created by Emilio Schepis on 14/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Foundation

class ReleasesParser: NSObject {
    typealias CompletionResult = ([Release]) -> Void
    
    private static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss z"
        return formatter
    }()
    
    private var releases = [Release]()
    private var currentElement = ""
    private var currentGuid = ""
    private var currentTitle = ""
    private var currentDescription = ""
    private var currentPubDate = ""
    private var completion: CompletionResult?
    
    func parse(data: Data, completion: @escaping CompletionResult) {
        self.completion = completion
        
        if data.isEmpty {
            completion([])
            return
        }
        
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
}

extension ReleasesParser: XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser) {
        releases.removeAll(keepingCapacity: true)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        // If we are about to start a new item clear the fields
        if currentElement == "item" {
            currentGuid = ""
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "guid":
            currentGuid += string.trimmingCharacters(in: .whitespacesAndNewlines)
        case "title":
            currentTitle += string.trimmingCharacters(in: .whitespacesAndNewlines)
        case "description":
            currentDescription += string.trimmingCharacters(in: .whitespacesAndNewlines)
        case "pubDate":
            currentPubDate += string.trimmingCharacters(in: .whitespacesAndNewlines)
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // If we are about to end an item add it to the list
        if elementName == "item" {
            guard let date = Self.formatter.date(from: currentPubDate) else {
                print("Could not convert \"\(currentPubDate)\" to Date.")
                return
            }
            
            let release = Release(id: currentGuid,
                                      title: currentTitle,
                                      description: currentDescription,
                                      date: date)
            
            releases.append(release)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        completion?(releases)
    }
}
