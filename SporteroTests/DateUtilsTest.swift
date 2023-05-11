//
//  DateUtilsTest.swift
//  SporteroTests
//
//  Created by Asalah Sayed on 11/05/2023.
//

import XCTest
@testable import Sportero
final class DateUtilsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidCurrentDate() {
        //Given
        let currentDate  = "2023-05-11"
        //When
        let result = DateUtils.getCurrentDate()
        //Then
        XCTAssertEqual(result, currentDate)
    }
    
    func testInValidCurrentDate() {
        //Given
        let currentDate  = "2023-05-5"
        //When
        let result = DateUtils.getCurrentDate()
        //Then
        XCTAssertNotEqual(result, currentDate)
    }

    func testValidToDate() {
        //Given
        let toDate  = "2023-05-21"
        //When
        let result = DateUtils.getToDate()
        //Then
        XCTAssertEqual(result, toDate)
    }
    
    func testInValidToDate() {
        //Given
        let toDate  = "2023-05-5"
        //When
        let result = DateUtils.getToDate()
        //Then
        XCTAssertNotEqual(result, toDate)
    }


}
