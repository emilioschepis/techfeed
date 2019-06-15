//
//  ReleasesParserTests.swift
//  TechfeedTests
//
//  Created by Emilio Schepis on 15/06/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import XCTest
@testable import Techfeed

class ReleasesParserTests: XCTestCase {
    
    var sut: ReleasesParser!
    
    override func setUp() {
        sut = ReleasesParser()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testEmptyDataReturnsNoNewsArticles() {
        // Arrange
        let data = Data()
        let expectation = XCTestExpectation(description: "Parser finishes parsing")
        
        // Act
        sut.parse(data: data) { releases in
            // Assert
            XCTAssertEqual(releases.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testDataReturnsCorrectNewsArticles() {
        // Arrange
        let article = """
        <item>
        <title>macOS Mojave 10.14.6 beta 2 (18G48f)</title>
        <link>https://developer.apple.com/news/?id=06112019d</link>
        <guid>https://developer.apple.com/news/?id=06112019d</guid>
        <description>macOS Mojave 10.14.6 beta 2 (18G48f)</description>
        <pubDate>Tue, 11 Jun 2019 10:00:00 PDT</pubDate>
        <content:encoded><![CDATA[macOS Mojave 10.14.6 beta 2 (18G48f)]]></content:encoded>
        </item>
        """
        
        let data = article.data(using: .utf8)!
        let expectation = XCTestExpectation(description: "Parser finishes parsing")
        
        // Act
        sut.parse(data: data) { articles in
            
            // Assert
            XCTAssertEqual(articles.count, 1)
            
            let article = articles.first!
            print(article.date.timeIntervalSince1970)
            XCTAssertEqual(article.id, "https://developer.apple.com/news/?id=06112019d")
            XCTAssertEqual(article.title, "macOS Mojave 10.14.6 beta 2 (18G48f)")
            XCTAssertEqual(article.date, Date(timeIntervalSince1970: 1560272400))
            XCTAssertEqual(article.description, "macOS Mojave 10.14.6 beta 2 (18G48f)")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
}
