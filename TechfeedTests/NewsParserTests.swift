//
//  NewsParserTests.swift
//  TechfeedTests
//
//  Created by Emilio Schepis on 15/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import XCTest
@testable import Techfeed

class NewsParserTests: XCTestCase {
    
    var sut: NewsParser!

    override func setUp() {
        sut = NewsParser()
    }

    override func tearDown() {
        sut = nil
    }
    
    func testEmptyDataReturnsNoNewsArticles() {
        // Arrange
        let data = Data()
        let expectation = XCTestExpectation(description: "Parser finishes parsing")
        
        // Act
        sut.parse(data: data) { articles in
            // Assert
            XCTAssertEqual(articles.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testDataReturnsCorrectNewsArticles() {
        // Arrange
        let article = """
        <item>
        <title>Updated App Store Links</title>
        <link>https://developer.apple.com/news/?id=06142019a</link>
        <guid>https://developer.apple.com/news/?id=06142019a</guid>
        <description>Links generated for apps on the App Store now begin with apps.apple.com. Existing links that begin with itunes.apple.com will continue to work in their current form and will automatically redirect to the apps.apple.com domain.</description>
        <pubDate>Fri, 14 Jun 2019 14:25:00 PDT</pubDate>
        <content:encoded><![CDATA[<p>Links generated for apps on the App&nbsp;Store now begin with apps.apple.com. Existing links that begin with itunes.apple.com will continue to work in their current form and will automatically redirect to the apps.apple.com domain.</p>]]></content:encoded>
        </item>
        """
        
        let data = article.data(using: .utf8)!
        let expectation = XCTestExpectation(description: "Parser finishes parsing")
        
        // Act
        sut.parse(data: data) { articles in
            
            // Assert
            XCTAssertEqual(articles.count, 1)
            
            let article = articles.first!
            XCTAssertEqual(article.id, "https://developer.apple.com/news/?id=06142019a")
            XCTAssertEqual(article.title, "Updated App Store Links")
            XCTAssertEqual(article.date, Date(timeIntervalSince1970: 1560547500))
            XCTAssertEqual(article.link, URL(string: "https://developer.apple.com/news/?id=06142019a"))
            XCTAssertEqual(article.description, "Links generated for apps on the App Store now begin with apps.apple.com. Existing links that begin with itunes.apple.com will continue to work in their current form and will automatically redirect to the apps.apple.com domain.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

}
