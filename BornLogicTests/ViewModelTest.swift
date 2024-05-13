//
//  ViewModelTest.swift
//  BornLogicTests
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import XCTest
@testable import BornLogic

class ViewModelTest: XCTestCase {

    var viewModel: ResponseViewModel!
    var mockDelegate: MockResponseViewModelDelegate!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        viewModel = ResponseViewModel()
        mockDelegate = MockResponseViewModelDelegate()
        viewModel.delegate = mockDelegate
        mockNetworkManager = MockNetworkManager()
        NetworkManager.shared = mockNetworkManager
    }

    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        NetworkManager.shared = NetworkManager()
        super.tearDown()
    }

    func testFetchArticlesWithDelegate() {

        let expectation = XCTestExpectation(description: "Articles loaded")
        let expectedArticleCount = 0
        viewModel.fetchArticlesWithDelegate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.mockDelegate.articles.count, expectedArticleCount)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testAddArticlesWithDelegate() {

        let initialArticleCount = mockDelegate.articles.count
        let expectation = XCTestExpectation(description: "Articles added")

        viewModel.addArticlesWithDelegate()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertGreaterThanOrEqual(self.mockDelegate.articles.count, initialArticleCount)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testLoadNextPage() {
        let category = "your_category"
        let initialArticleCount = mockDelegate.articles.count
        let expectation = XCTestExpectation(description: "Next page loaded")

        viewModel.loadNextPage(by: category)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertGreaterThanOrEqual(self.mockDelegate.articles.count, initialArticleCount)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testGetMyCategoryStories() {
        let category = "your_category"
        let expectedPage = "1"

        viewModel.getMyCategoryStories(by: category)

        XCTAssertEqual(mockNetworkManager.lastCategory, category)
        XCTAssertEqual(mockNetworkManager.lastPage, expectedPage)
    }

    func testSearchURL() {
        let searchText = "your_search_text"
        viewModel.searchURL(with: searchText)
        XCTAssertEqual(mockNetworkManager.lastSearchText, searchText)

    }
}

class MockResponseViewModelDelegate: ResponseViewModelDelegate {
    var articles = [Article]()

    func loadArticles(_ articles: [Article]) {
        self.articles = articles
    }
}

class MockNetworkManager: NetworkManager {
    var lastCategory: String?
    var lastPage: String?
    var lastSearchText: String?

    override func getMyCategoryStories(by category: String, andPage page: String) {
        lastCategory = category
        lastPage = page
    }

    override func searchURL(with text: String) {
        lastSearchText = text
    }
}
