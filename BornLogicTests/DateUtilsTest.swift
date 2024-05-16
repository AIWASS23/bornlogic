//
//  DateUtilsTest.swift
//  BornLogicTests
//
//  Created by Marcelo De Araújo on 16/05/24.
//

import XCTest
@testable import BornLogic

class DateUtilsTest: XCTestCase {

    var dateFormatter: DateFormatter!

    override func setUp() {
        super.setUp()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }

    override func tearDown() {
        dateFormatter = nil
        super.tearDown()
    }

    func testConvertFromStringToDate() {
        
        let dateString = "2021-05-15T08:00:00"
        let expectedDate = dateFormatter.date(from: dateString)

        let date = DateUtil.produceDate(dateString: dateString, dateFormat: "yyyy-MM-dd'T'HH:mm:ss")

        XCTAssertEqual(date, expectedDate)
    }

    func testConvertFromDateToString() {

        let date = dateFormatter.date(from: "2021-05-15T08:00:00")
        let expectedDateString = "2021-05-15T08:00:00"

        let dateString = DateUtil.convert(input: date!, outputFormat: DateUtil.AppDateFormat.format2)

        XCTAssertEqual(dateString, expectedDateString)
    }

    func testConvertFromStringToString() {

        let inputDateString = "2021-05-15T08:00:00"
        let expectedDateString = "May 15, 2021"

        let outputDateString = DateUtil.convert(input: inputDateString, inputFormat: DateUtil.AppDateFormat.format2, outputFormat: DateUtil.AppDateFormat.format5)

        XCTAssertEqual(outputDateString, expectedDateString)
    }
}


