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
}
