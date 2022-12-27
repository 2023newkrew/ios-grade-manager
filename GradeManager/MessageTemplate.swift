//
//  MessageTemplate.swift
//  GradeManager
//
//  Created by john-lim on 2022/12/27.
//

import Foundation

enum MessageTemplate: String, CustomStringConvertible {
    case selectMenu =
    """
    원하는 기능을 입력해주세요
    1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
    """
    case wrongMenu = "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요"
    
    case exitProgram = "프로그램을 종료합니다..."
    
    var description: String {
        return self.rawValue
    }
}

func print(template: MessageTemplate){
    print(template)
}
