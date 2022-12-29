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
    case invalidInput
    case duplicatedStudent(name: String)
    case completeAddStudent(name: String)
    case deleteStudent
    case notExistStudent(name: String)
    case completeDeleteStudent(name: String)
    case inputScore
    case deleteScore
    case completeAddScore(name: String, subject: String, grade: Grade)
    case completeDeleteScore(name: String, subject: String)
    case notFoundSubject
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
        case .invalidInput:
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
        case .inputScore:
            return
        """
        성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
        입력예) Mickey Swift A+
        만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
        """
        case .deleteScore:
            return
        """
        성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
        입력예) Mickey Swift
        """
        case .completeAddScore(let name, let subject, let grade):
            return "\(name) 학생의 \(subject) 과목이 \(grade.rawValue)로 추가(변경)되었습니다."
        case .completeDeleteScore(let name, let subject):
            return "\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다."
        case .notFoundSubject:
            return "과목명이 잘못 입력되었습니다."
        case .exitProgram:
            return "프로그램을 종료합니다..."
        }
    }
}

func print(template: MessageTemplate) {
    print(template)
}
