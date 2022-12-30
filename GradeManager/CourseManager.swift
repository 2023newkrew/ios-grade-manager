//
//  CourseManager.swift
//  GradeManager
//
//  Created by kakao on 2022/12/30.
//

import Foundation

struct CourseManager {
    private enum InfoMessage: String {
        case invalidGrade = "잘못된 성적입니다."
        case notExistSubject = "성적이 존재하지 않는 과목입니다."
        case addOrChangeGrade
        case deleteGrade
        
        func printing(name: String? = nil, subject: String? = nil, grade: String? = nil) {
            switch self {
            case .invalidGrade, .notExistSubject:
                print(self.rawValue)
            case .addOrChangeGrade:
                guard let name = name, let subject = subject, let grade = grade else {
                    return
                }
                print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경) 되었습니다.")
            case .deleteGrade:
                guard let name = name, let subject = subject else {
                    return
                }
                print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
            }
        }
    }
    
    private enum Grade: String {
        case Aplus = "A+"
        case Azero = "A0"
        case Bplus = "B+"
        case Bzero = "B0"
        case Cplus = "C+"
        case Czero = "C0"
        case Dplus = "D+"
        case Dzero = "D0"
        case F = "F"
        
        var score: Double {
            switch self {
            case .Aplus:
                return 4.5
            case .Azero:
                return 4.0
            case .Bplus:
                return 3.5
            case .Bzero:
                return 3.0
            case .Cplus:
                return 2.5
            case .Czero:
                return 2.0
            case .Dplus:
                return 1.5
            case .Dzero:
                return 1.0
            case .F:
                return 0.0
            }
        }
    }
    private var list: [String: Grade] = [:]
    
    mutating func add(name: String, subject: String, grade: String) {
        guard let gradeLevel = Grade(rawValue: grade) else {
            InfoMessage.invalidGrade.printing()
            return
        }
        list[subject] = gradeLevel
        InfoMessage.addOrChangeGrade.printing(name: name, subject: subject, grade: grade)
    }
    
    mutating func delete(name: String, subject: String) {
        guard let _ = list[subject] else {
            InfoMessage.notExistSubject.printing()
            return
        }
        list[subject] = nil
        InfoMessage.deleteGrade.printing(name: name, subject: subject)
    }
    
    func averageScore() -> Double {
        return list.map { $0.value.score }.reduce(0, +) / Double(list.count)
    }
    
    func showAverageScore() {
        print(list.count)
        list.forEach { (subject, grade) in
            print("\(subject): \(grade.score)")
        }
        print("평점 : \(averageScore())")
    }
}
