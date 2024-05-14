//
//  MenuControllerTest.swift
//  BornLogicTests
//
//  Created by Marcelo De Araújo on 14/05/24.
//

import XCTest
@testable import BornLogic

class MenuViewControllerTests: XCTestCase {
    
    var sut: MenuViewController!
    
    override func setUpWithError() throws {
        sut = MenuViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testCollectionViewIsNotNil() throws {
        XCTAssertNotNil(sut.menuCollectionView)
    }
    
    func testCollectionViewDataSourceIsSet() throws {
        XCTAssertNotNil(sut.menuCollectionView.dataSource)
        XCTAssertTrue(sut.menuCollectionView.dataSource === sut)
    }
    
    func testCollectionViewDelegateIsSet() throws {
        XCTAssertNotNil(sut.menuCollectionView.delegate)
        XCTAssertTrue(sut.menuCollectionView.delegate === sut)
    }
    
    func testSearchControllerIsNotNil() throws {
        XCTAssertNotNil(sut.search)
    }
    
    func testSearchControllerDelegateIsSet() throws {
        XCTAssertNotNil(sut.search.searchBar.delegate)
        XCTAssertTrue(sut.search.searchBar.delegate === sut)
    }
    
    func testConfigureNavigationBar() throws {
        XCTAssertTrue(sut.navigationController?.navigationBar.prefersLargeTitles ?? false)
        XCTAssertEqual(sut.navigationItem.title, sut.titleName)
    }
}
