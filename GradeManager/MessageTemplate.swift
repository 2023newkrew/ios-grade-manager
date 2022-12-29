//
//  MessageTemplate.swift
//  GradeManager
//
//  Created by john-lim on 2022/12/27.
//

import Foundation

enum MessageTemplate: CustomStringConvertible {
    case selectMenu
    case wrongMenu
    case inputStudent
    case invalidStudentName
    case duplicatedStudent(name: String)
    case completeAddStudent(name: String)
    case deleteStudent
    case notExistStudent(name: String)
    case completeDeleteStudent(name: String)
    case exitProgram
    
    var description: String {
        switch self {
        case .selectMenu:
            return
        """
        원하는 기능을 입력해주세요
        1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
        """
        case .wrongMenu:
            return "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요"
        case .inputStudent:
            return "추가할 학생의 이름을 입력해주세요"
        case .invalidStudentName:
            return "입력이 잘못되었습니다. 다시 확인해주세요."
        case .duplicatedStudent(let name):
            return "\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다."
        case .completeAddStudent(let name):
            return "\(name) 학생을 추가했습니다."
        case .deleteStudent:
            return "삭제할 학생의 이름을 입력해주세요"
        case .notExistStudent(let name):
            return "\(name) 학생을 찾지 못했습니다."
        case .completeDeleteStudent(let name):
            return "\(name) 학생을 삭제하였습니다."
        case .exitProgram:
            return "프로그램을 종료합니다..."
        }
    }
}

func print(template: MessageTemplate) {
    print(template)
}
