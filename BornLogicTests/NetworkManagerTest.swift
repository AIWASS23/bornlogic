//
//  NetworkManagerTest.swift
//  BornLogicTests
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import XCTest
@testable import BornLogic

class NetworkManagerTest: XCTestCase {

    var networkManager: NetworkManager!
    var model: Response!
    var article: Article!
    var source: Source!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
        model = Response(status: "ok", totalResults: 10, articles: [])
        article = Article(source: Source(name: ""), author: nil, title: "", description: nil, url: nil, urlToImage: nil, publishedAt: "", content: nil)
        source = Source(name: "")
    }

    override func tearDown() {
        networkManager = nil
        model = nil
        article = nil
        source = nil
        super.tearDown()
    }

    func testGetMyTopStories() {
        let expectation = self.expectation(description: "getMyTopStories")

        networkManager.onCompletionData = { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.totalResults, 0)
            expectation.fulfill()
        }

        networkManager.getMyTopStories()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetMyTopStoriesByPage() {
        let expectation = self.expectation(description: "getMyTopStoriesByPage")
        let page = "2"

        networkManager.onCompletionData = { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.totalResults, 0)
            expectation.fulfill()
        }

        networkManager.getMyTopStories(byPage: page)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetMyUaSportsStories() {
        let expectation = self.expectation(description: "getMyUaSportsStories")

        networkManager.onCompletionData = { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.totalResults, 0)
            expectation.fulfill()
        }

        networkManager.getMySportsStories()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetMyUaSportsStoriesByPage() {
        let expectation = self.expectation(description: "getMyUaSportsStoriesByPage")
        let page = "2"

        networkManager.onCompletionData = { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.totalResults, 0)
            expectation.fulfill()
        }

        networkManager.getMySportsStories(byPage: page)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetMyCategoryStories() {
        let expectation = self.expectation(description: "getMyCategoryStories")
        let category = "technology"

        networkManager.onCompletionData = { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.totalResults, 0)
            expectation.fulfill()
        }

        networkManager.getMyCategoryStories(by: category)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetMyCategoryStoriesByPage() {
        let expectation = self.expectation(description: "getMyCategoryStoriesByPage")
        let category = "health"
        let page = "2"

        networkManager.onCompletionData = { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.totalResults, 0)
            expectation.fulfill()
        }

        networkManager.getMyCategoryStories(by: category, andPage: page)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testSearchURL() {
        let expectation = self.expectation(description: "searchURL")
        let query = "apple"

        networkManager.onCompletionData = { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.totalResults, 0)
            expectation.fulfill()
        }

        networkManager.searchURL(with: query)

        waitForExpectations(timeout: 5, handler: nil)
    }
}
