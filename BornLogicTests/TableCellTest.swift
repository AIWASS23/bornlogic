//
//  TableCellTest.swift
//  BornLogicTests
//
//  Created by Marcelo De Araújo on 14/05/24.
//

import XCTest
@testable import BornLogic

class ArticleTableViewCellTests: XCTestCase {

    var cell: ArticleTableViewCell!

    override func setUp() {
        super.setUp()
        cell = ArticleTableViewCell(style: .default, reuseIdentifier: ArticleTableViewCell.identifier)
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testCellHasTitleLabel() {
        XCTAssertNotNil(cell.titleLabel)
    }

    func testCellHasDescriptionLabel() {
        XCTAssertNotNil(cell.descriptionLabel)
    }

    func testCellHasAuthorLabel() {
        XCTAssertNotNil(cell.authorLabel)
    }

    func testCellHasArticleImageView() {
        XCTAssertNotNil(cell.articleImageView)
    }

    func testCellConfigureWithTitle() {
        let article = Article(source: Source(name: "Test"), author: "John Doe", title: "Title", description: "Description", url: "https://example.com", urlToImage: "https://example.com/image.jpg", publishedAt: "2024-05-13T12:00:00Z", content: "Content")
        cell.configure(with: article)

        XCTAssertEqual(cell.titleLabel.text, "Title")
    }

    func testCellConfigureWithDescription() {
        let article = Article(source: Source(name: "Test"), author: "John Doe", title: "Title", description: "Description", url: "https://example.com", urlToImage: "https://example.com/image.jpg", publishedAt: "2024-05-13T12:00:00Z", content: "Content")
        cell.configure(with: article)

        XCTAssertEqual(cell.descriptionLabel.text, "Description")
    }

    func testCellConfigureWithAuthor() {
        let article = Article(source: Source(name: "Test"), author: "John Doe", title: "Title", description: "Description", url: "https://example.com", urlToImage: "https://example.com/image.jpg", publishedAt: "2024-05-13T12:00:00Z", content: "Content")
        cell.configure(with: article)

        XCTAssertEqual(cell.authorLabel.text, "John Doe")
    }

    func testCellConfigureWithImageURL() {
        let expectation = XCTestExpectation(description: "Image loaded")

        let article = Article(source: Source(name: "Test"), author: "John Doe", title: "Title", description: "Description", url: "https://example.com", urlToImage: "https://picsum.photos/300?random=\(UUID().uuidString)", publishedAt: "2024-05-13T12:00:00Z", content: "Content")

        cell.configure(with: article)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertNotNil(self.cell.articleImageView.image)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }


    func testCellConfigureWithNoImageURL() {
        let article = Article(source: Source(name: "Test"), author: "John Doe", title: "Title", description: "Description", url: "https://example.com", urlToImage: nil, publishedAt: "2024-05-13T12:00:00Z", content: "Content")
        cell.configure(with: article)

        XCTAssertNotNil(cell.articleImageView.image)
    }

}
