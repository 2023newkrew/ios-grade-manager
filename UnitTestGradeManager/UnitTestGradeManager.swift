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
        let result = sut.menuChoice()
        switch result {
        case .success(let data):
            XCTAssertEqual(data, "1")
        case .failure:
            XCTFail()
        }
    }
    
    func test_input_menu_2() {
        let result = sut.menuChoice()
        switch result {
        case .success(let data):
            XCTAssertEqual(data, "2")
        case .failure:
            XCTFail()
        }
    }
    
    func test_input_menu_3() {
        let result = sut.menuChoice()
        switch result {
        case .success(let data):
            XCTAssertEqual(data, "3")
        case .failure:
            XCTFail()
        }
    }
    
    func test_input_menu_4() {
        let result = sut.menuChoice()
        switch result {
        case .success(let data):
            XCTAssertEqual(data, "4")
        case .failure:
            XCTFail()
        }
    }
    
    func test_input_menu_5() {
        let result = sut.menuChoice()
        switch result {
        case .success(let data):
            XCTAssertEqual(data, "5")
        case .failure:
            XCTFail()
        }
    }
    
    func test_input_menu_X() {
        let result = sut.menuChoice()
        switch result {
        case .success(let data):
            XCTAssertEqual(data, "X")
        case .failure:
            XCTFail()
        }
    }
    
    func test_input_menu_error() {
        let result = sut.menuChoice()
        switch result {
        case .success:
            XCTFail()
        case .failure:
            XCTAssert(true)
        }
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
