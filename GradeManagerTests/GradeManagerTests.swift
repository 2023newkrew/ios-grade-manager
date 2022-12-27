//
//  GradeManagerTests.swift
//  GradeManagerTests
//
//  Created by kakao on 2022/12/27.
//

import XCTest

final class GradeManagerTests: XCTestCase {
    let sut: GradeManager = GradeManager()
    
    func test_잘못된메뉴선택() {
        //given
        let input = "6"

        //when
        let result = sut.menu(command: input)
        
        //then
        XCTAssertEqual(result, nil)
    }
    
    func test_중복_학생_입력_시_오류() {
        //given
        let input = "dupStudent"
        
        //when
        sut.addStudent(of: input)
        
        //then
        let result = sut.isValid(name: input)
        XCTAssertEqual(result, false)
    }
    
    func test_미중복_학생_입력_시_통과() {
        //given
        let input = "Student"
        let currentStudentCount = sut.students.count
        
        //when
        sut.addStudent(of: input)
        
        //then
        let result = sut.students.count
        XCTAssertEqual(result, currentStudentCount + 1)
    }
}
