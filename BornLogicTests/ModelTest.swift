//
//  NetworkTests.swift
//  BornLogicTests
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import XCTest
@testable import BornLogic

class ModelTests: XCTestCase {

    var model: Response!
    var article: Article!
    var source: Source!

    override func setUp() {
        super.setUp()
        model = Response(status: "ok", totalResults: 10, articles: [])
        article = Article(source: Source(name: ""), author: nil, title: "", description: nil, url: nil, urlToImage: nil, publishedAt: "", content: nil)
        source = Source(name: "")
    }

    override func tearDown() {
        model = nil
        article = nil
        source = nil
        super.tearDown()
    }

    func testArticleNotEquality() {
        let source = Source(name: "CNN")
        let article1 = Article(source: source, author: "John Doe", title: "Title 1", description: "Description 1", url: "https://example.com", urlToImage: "https://example.com/image.jpg", publishedAt: "2024-05-13T12:00:00Z", content: "Content 1")
        let article2 = Article(source: source, author: "John Doe", title: "Title 1", description: "Description 1", url: "https://example.com", urlToImage: "https://example.com/image.jpg", publishedAt: "2024-05-13T12:00:00Z", content: "Content 1")
        XCTAssertNotEqual(article1, article2)
    }

    func testArticleHashing() {
        let source = Source(name: "BBC")
        let article = Article(source: source, author: "Jane Doe", title: "Title 2", description: "Description 2", url: "https://example.com", urlToImage: "https://example.com/image.jpg", publishedAt: "2024-05-13T12:00:00Z", content: "Content 2")
        let expectedHash = article.uuid.hashValue
        XCTAssertEqual(article.hashValue, expectedHash)
    }

    func testSourceDecoding() {
        let jsonData = """
            {"name": "The New York Times"}
            """.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let source = try decoder.decode(Source.self, from: jsonData)
            XCTAssertEqual(source.name, "The New York Times")
        } catch {
            XCTFail("Erro ao decodificar JSON para Source: \(error)")
        }
    }

    func testArticleDecoding() {
        let jsonData = """
            {
                "source": {"name": "Fox News"},
                "author": "John Smith",
                "title": "Title 3",
                "description": "Description 3",
                "url": "https://example.com",
                "urlToImage": "https://example.com/image.jpg",
                "publishedAt": "2024-05-13T12:00:00Z",
                "content": "Content 3"
            }
            """.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let article = try decoder.decode(Article.self, from: jsonData)
            XCTAssertEqual(article.source.name, "Fox News")
            XCTAssertEqual(article.author, "John Smith")
            XCTAssertEqual(article.title, "Title 3")
            XCTAssertEqual(article.description, "Description 3")
            XCTAssertEqual(article.url, "https://example.com")
            XCTAssertEqual(article.urlToImage, "https://example.com/image.jpg")
            XCTAssertEqual(article.publishedAt, "2024-05-13T12:00:00Z")
            XCTAssertEqual(article.content, "Content 3")
        } catch {
            XCTFail("Erro ao decodificar JSON para Article: \(error)")
        }
    }
}
