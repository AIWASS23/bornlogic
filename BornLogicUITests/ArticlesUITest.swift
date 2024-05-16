//
//  ArticlesUITest.swift
//  BornLogicUITests
//
//  Created by Marcelo De Araújo on 16/05/24.
//

import XCTest

final class ArticlesUITest: XCTestCase {

    override func setUpWithError() throws {
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {}

    func testArticles() throws {

        let app = XCUIApplication()
        app.launch()

    }
}
