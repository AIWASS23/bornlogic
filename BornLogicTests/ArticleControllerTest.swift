//
//  ArticleControllerTest.swift
//  BornLogicTests
//
//  Created by Marcelo De Araújo on 14/05/24.
//

import XCTest
@testable import BornLogic

final class ArticleControllerTest: XCTestCase {

    var sut: ArticleViewController!

    override func setUpWithError() throws {
        sut = ArticleViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testTableViewIsNotNil() throws {
        XCTAssertNotNil(sut.tableView)
    }

    func testTableViewDelegateIsSet() throws {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate === sut)
    }

    func testViewModelDelegateIsSet() throws {
        XCTAssertNotNil(sut.viewModel.delegate)
        XCTAssertTrue(sut.viewModel.delegate === sut)
    }

    func testDataSourceIsNotNil() throws {
        XCTAssertNotNil(sut.dataSource)
    }
}
