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
}
