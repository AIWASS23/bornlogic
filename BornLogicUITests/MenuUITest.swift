//
//  BornLogicUITests.swift
//  BornLogicUITests
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import XCTest

final class MenuUITest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {}

    func testMenu() throws {

        let app = XCUIApplication()
        app.launch()

        let collectionView = app.collectionViews["menuCollectionView"]
        let collectionViewCells = collectionView.cells

        if collectionViewCells.count > 0 {
            for i in 0 ..< collectionViewCells.count {
                let collectionViewCell = collectionViewCells.element(boundBy: i)
                XCTAssertTrue(collectionViewCell.exists, "Cell \(i) exists")

                collectionViewCell.tap()

                XCTAssertTrue(app.navigationBars["Artigos"].waitForExistence(timeout: 5))

                let tableView = app.tables["tableView"]
                XCTAssertTrue(tableView.waitForExistence(timeout: 5))

                let tableViewCells = tableView.cells
                if tableViewCells.count > 0 {
                    print(tableViewCells.count)
                    let firstCell = tableViewCells.element(boundBy: 0)
                    firstCell.tap()

                    XCTAssertTrue(app.navigationBars["Noticia"].waitForExistence(timeout: 5))
                }
                app.navigationBars.buttons.element(boundBy: 0).tap()
            }
        }
    }

    func testSearch() throws {
        let app = XCUIApplication()

        let searchBar = app.searchFields["Pesquisa"]
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5))

        searchBar.tap()
        searchBar.typeText("Apple")

        searchBar.typeText("\n")

        let tableView = app.tables["tableView"]
        XCTAssertTrue(tableView.waitForExistence(timeout: 5))

        let tableViewCells = tableView.cells
        if tableViewCells.count > 0 {
            let firstCell = tableViewCells.element(boundBy: 0)
            firstCell.tap()

            XCTAssertTrue(app.navigationBars["Noticia"].waitForExistence(timeout: 5))
        }
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
}
