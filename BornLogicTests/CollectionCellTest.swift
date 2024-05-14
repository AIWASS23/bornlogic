//
//  CollectionCellTest.swift
//  BornLogicTests
//
//  Created by Marcelo De Araújo on 14/05/24.
//

import XCTest
@testable import BornLogic

class MenuCollectionViewCellTests: XCTestCase {

    var cell: MenuCollectionViewCell!

    override func setUp() {
        super.setUp()
        cell = MenuCollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testCellHasNameLabel() {
        XCTAssertNotNil(cell.nameLabel)
    }

    func testCellConfigureWithCategories() {
        let categories: [String: UIColor] = [
            Menu.general: UIColor.purple,
            Menu.business: UIColor.green,
            Menu.science: UIColor.orange,
            Menu.technology: UIColor.blue,
            Menu.health: UIColor.red,
            Menu.entertainment: UIColor.yellow,
            Menu.sports: UIColor.gray,
            "Unknown": UIColor.brown
        ]

        for (category, color) in categories {
            cell.configureBy(category: category)
            XCTAssertEqual(cell.backgroundColor, color)
            XCTAssertEqual(cell.nameLabel.text, category)
            XCTAssertEqual(cell.nameLabel.textColor, UIColor.black)
        }
    }


    func testCellConfigureWithUnknownCategory() {
        cell.configureBy(category: "Unknown")
        XCTAssertEqual(cell.backgroundColor, UIColor.brown)
        XCTAssertEqual(cell.nameLabel.text, "Unknown")
        XCTAssertEqual(cell.nameLabel.textColor, UIColor.black)
    }

}
