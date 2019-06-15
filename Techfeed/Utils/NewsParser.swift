//
//  NewsParser.swift
//  Techfeed
//
//  Created by Emilio Schepis on 14/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Foundation

class NewsParser: NSObject {
    typealias CompletionResult = ([NewsArticle]) -> Void
    
    private static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss z"
        return formatter
    }()
    
    private var news = [NewsArticle]()
    private var currentElement = ""
    private var currentGuid = ""
    private var currentTitle = ""
    private var currentDescription = ""
    private var currentLink = ""
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

extension NewsParser: XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser) {
        news.removeAll(keepingCapacity: true)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        // If we are about to start a new item clear the fields
        if currentElement == "item" {
            currentGuid = ""
            currentTitle = ""
            currentDescription = ""
            currentLink = ""
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
        case "link":
            currentLink += string.trimmingCharacters(in: .whitespacesAndNewlines)
        case "pubDate":
            currentPubDate += string.trimmingCharacters(in: .whitespacesAndNewlines)
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // If we are about to end an item add it to the list
        if elementName == "item" {
            guard let link = URL(string: currentLink) else {
                print("Could not convert \"\(currentLink)\" to URL.")
                return
            }
            guard let date = Self.formatter.date(from: currentPubDate) else {
                print("Could not convert \"\(currentPubDate)\" to Date.")
                return
            }
            
            let description = currentDescription.replacingOccurrences(of: "Learn more", with: "")
            
            let article = NewsArticle(id: currentGuid,
                                      title: currentTitle,
                                      description: description,
                                      date: date,
                                      link: link)
            
            news.append(article)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        completion?(news)
    }
}
