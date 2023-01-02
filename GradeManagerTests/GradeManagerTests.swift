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
        XCTAssertEqual(result, .error)
    }

    func test_학생_정상_추가_시_학생수_증가() {
        //given
        let student1 = "Forest"
        let student2 = "John"
        sut.addStudent(of: student1)
        sut.addStudent(of: student2)
        let currentStudentCount = sut.students.count
        
        //when
        let input = "Volga"
        sut.addStudent(of: input)
        
        //then
        let result = sut.students.count
        XCTAssertEqual(result, currentStudentCount + 1)
    }
    
    func test_학생_중복_추가_시_학생수_유지() {
        //given
        let student1 = "Forest"
        let student2 = "John"
        sut.addStudent(of: student1)
        sut.addStudent(of: student2)
        let currentStudentCount = sut.students.count
        
        //when
        let input = "Forest"
        sut.addStudent(of: input)
        
        //then
        let result = sut.students.count
        XCTAssertEqual(result, currentStudentCount)
    }
    
    func test_학생_삭제_시_학생수_감소() {
        //given
        let input1 = "Forest"
        let input2 = "John"
        sut.addStudent(of: input1)
        sut.addStudent(of: input2)
        let currentStudentCount = sut.students.count
        
        //when
        sut.deleteStudent(of: "Forest")
        
        //then
        let result = sut.students.count
        XCTAssertEqual(result, currentStudentCount - 1)
    }
    
    func test_학생_삭제_실패시_학생수_유지() {
        //given
        let input1 = "Forest"
        let input2 = "John"
        sut.addStudent(of: input1)
        sut.addStudent(of: input2)
        let currentStudentCount = sut.students.count
        
        //when
        sut.deleteStudent(of: "Volga")
        
        //then
        let result = sut.students.count
        XCTAssertEqual(result, currentStudentCount)
    }
    
    func test_성적_추가_시_학생의_성적표_목록_수_증가() {
        //given
        sut.addStudent(of: "Forest")
        guard let currentSubjectCount = sut.students["Forest"]?.scores.count else {
            return XCTFail("테스트 실패")
        }
        
        //when
        let scoreFormat = "Forest Python A+"
        sut.addScore(format: scoreFormat)
        
        //then
        guard let result = sut.students["Forest"]?.scores.count else {
            return XCTFail("테스트 실패")
        }
        XCTAssertEqual(result, currentSubjectCount + 1)
    }
    
    func test_잘못된_성적_추가_시_학생의_성적표_목록_수_유지() {
        //given
        sut.addStudent(of: "Forest")
        guard let currentSubjectCount = sut.students["Forest"]?.scores.count else {
            return XCTFail("테스트 실패")
        }
        
        //when
        let scoreFormat = "i have no idea"
        sut.addScore(format: scoreFormat)
        
        //then
        guard let result = sut.students["Forest"]?.scores.count else {
            return XCTFail("테스트 실패")
        }
        XCTAssertEqual(result, currentSubjectCount)
    }
    
    func test_성적_삭제_시_학생의_성적표_목록_수_감소() {
        //given
        sut.addStudent(of: "Forest")
        sut.addScore(format: "Forest Swift A+")
        sut.addScore(format: "Forest Python B+")
        guard let currentSubjectCount = sut.students["Forest"]?.scores.count else {
            return XCTFail("테스트 실패")
        }
        
        //when
        let scoreFormat = "Forest Python"
        sut.deleteScore(format: scoreFormat)
        
        //then
        guard let result = sut.students["Forest"]?.scores.count else {
            return XCTFail("테스트 실패")
        }
        XCTAssertEqual(result, currentSubjectCount - 1)
    }
    
    func test_잘못된_과목_삭제_시_학생의_성적표_목록_수_유지() {
        //given
        sut.addStudent(of: "Forest")
        sut.addScore(format: "Forest Swift A+")
        sut.addScore(format: "Forest Python B+")
        guard let currentSubjectCount = sut.students["Forest"]?.scores.count else {
            return XCTFail("테스트 실패")
        }
        
        //when
        let scoreFormat = "Forest C++"
        sut.deleteScore(format: scoreFormat)
        
        //then
        guard let result = sut.students["Forest"]?.scores.count else {
            return XCTFail("테스트 실패")
        }
        XCTAssertEqual(result, currentSubjectCount)
    }
}
