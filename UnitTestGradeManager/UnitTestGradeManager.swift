//
//  UnitTestGradeManager.swift
//  UnitTestGradeManager
//
//  Created by kakao on 2022/12/27.
//

import XCTest

class UnitTestGradeManager: XCTestCase {
    
    let sut = GradeManager()
    
    func test_input_menu_1() {
        guard let result = sut.menuChoice() else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, "1")
    }
    
    func test_input_menu_2() {
        guard let result = sut.menuChoice() else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, "2")
    }
    
    func test_input_menu_3() {
        guard let result = sut.menuChoice() else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, "3")
    }
    
    func test_input_menu_4() {
        guard let result = sut.menuChoice() else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, "4")
    }
    
    func test_input_menu_5() {
        guard let result = sut.menuChoice() else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, "5")
    }
    
    func test_input_menu_X() {
        guard let result = sut.menuChoice() else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, "X")
    }
    
    func test_input_menu_error() {
        XCTAssertNil(sut.menuChoice())
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
