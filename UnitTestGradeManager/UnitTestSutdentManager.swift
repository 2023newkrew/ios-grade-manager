//
//  UnitTestSutdentManager.swift
//  UnitTestGradeManager
//
//  Created by kakao on 2022/12/29.
//

import XCTest

final class UnitTestSutdentManager: XCTestCase {
    
    var sut = DefaultStudentManager()
    
    func randomStudent() -> String {
        let student1 = "summer.love"
        let student2 = "volga.poco"
        let student3 = "forest.jay"
        let student4 = "john.lim"
        let student5 = "yagom"
        let student6 = "kio"
        let student7 = "수박"
        let student8 = "라자냐"
        let students = [student1, student2, student3, student4, student5, student6, student7, student8]
        
        return students.shuffled()[0]
    }
    
    func test_학생을_추가했을_경우_학생들의_수가_1_증가한다() {
        let studentCountBeforeAdd = sut.numberOfStudent
        sut.addStudent(name: randomStudent())
        let studentCountAfterAdd = sut.numberOfStudent
        XCTAssertEqual(studentCountBeforeAdd + 1, studentCountAfterAdd)
    }
    
    func test_있는_학생을_추가했을_경우_학생들의_수가_증가_하지_않는다() {
        let studentName = randomStudent()
        
        sut.addStudent(name: studentName)
        let studentCountBeforeAdd = sut.numberOfStudent
        
        sut.addStudent(name: studentName)
        let studentCountAfterAdd = sut.numberOfStudent
        XCTAssertEqual(studentCountBeforeAdd, studentCountAfterAdd)
    }
    
    func test_학생을_추가했을_경우_입력한_이름이_올바르게_들어간다() {
        let studentName = randomStudent()
        
        let isStudentExistBeforeAdd = sut.isExist(name: studentName)
        XCTAssertFalse(isStudentExistBeforeAdd)
        
        sut.addStudent(name: studentName)
        
        let isStudentExistAfterAdd = sut.isExist(name: studentName)
        XCTAssertTrue(isStudentExistAfterAdd)
    }
    
    func test_학생을_삭제_했을_경우_학생들의_수가_1_감소한다() {
        let studentName = randomStudent()
        sut.addStudent(name: studentName)
        
        let studentCountBeforeAdd = sut.numberOfStudent
        sut.deleteStudent(name: studentName)
        
        let studentCountAfterAdd = sut.numberOfStudent
        XCTAssertEqual(studentCountBeforeAdd - 1, studentCountAfterAdd)
    }
    
    func test_없는_학생을_삭제_했을_경우_학생들의_수가_1_감소하지_않는다() {
        let studentName = randomStudent()
        sut.addStudent(name: studentName)
        
        sut.deleteStudent(name: studentName)
        let studentCountBeforeAdd = sut.numberOfStudent
        
        sut.deleteStudent(name: studentName)
        let studentCountAfterAdd = sut.numberOfStudent
        
        XCTAssertEqual(studentCountBeforeAdd, studentCountAfterAdd)
    }
    
    func test_학생을_삭제_할_경우_입력한_이름이_올바르게_삭제된다() {
        let studentName = randomStudent()        
        sut.addStudent(name: studentName)
        
        let isStudentExistBeforeAdd = sut.isExist(name: studentName)
        XCTAssertTrue(isStudentExistBeforeAdd)
        
        sut.deleteStudent(name: studentName)
        
        let isStudentExistAfterAdd = sut.isExist(name: studentName)
        XCTAssertFalse(isStudentExistAfterAdd)
    }
}
