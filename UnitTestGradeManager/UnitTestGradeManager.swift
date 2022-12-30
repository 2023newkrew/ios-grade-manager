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
        XCTAssertEqual(result, .addStudent)
    }
    
    func test_input_menu_2() {
        guard let result = sut.menuChoice() else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, .deleteStudent)
    }
    
    func test_input_menu_3() {
        guard let result = sut.menuChoice() else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, .addOrChangeGrade)
    }
    
    func test_input_menu_4() {
        guard let result = sut.menuChoice() else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, .deleteGrade)
    }
    
    func test_input_menu_5() {
        guard let result = sut.menuChoice() else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, .viewAverageScore)
    }
    
    func test_input_menu_X() {
        guard let result = sut.menuChoice() else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, .exitGradeManager)
    }
    
    func test_input_menu_error() {
        XCTAssertNil(sut.menuChoice())
    }
}
