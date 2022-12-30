//
//  StudentManager.swift
//  GradeManager
//
//  Created by kakao on 2022/12/30.
//

import Foundation

protocol StudentManager {
    mutating func addStudent(name: String)
    mutating func deleteStudent(name: String)
    mutating func addOrChangeGrade(name: String, subject: String, grade: String)
    mutating func deleteGrade(name: String, subject: String)
    func viewAverageScore(name: String)
}

struct DefaultStudentManager: StudentManager {
    private enum InfoMessage: String {
        case addSuccess = " 학생을 추가했습니다."
        case addFailure = "입력이 잘못되었습니다. 다시 확인해주세요."
        case deleteSuccess = "학생을 삭제하였습니다."
        case canNotFindStudent = " 학생을 찾지 못했습니다."
        
        func printing(name: String) {
            switch self {
            case .addSuccess, .canNotFindStudent:
                print(name, terminator: "")
                print(self.rawValue)
            default:
                print(self.rawValue)
            }
        }
    }
    
    private var list = Set<Student>()
    
    var numberOfStudent: Int {
        return self.list.count
    }
    
    func isExist(name: String) -> Bool {
        return list.contains(Student(name: name))
    }
    
    func studentToBeDeleted(name: String) -> Student? {
        let student = list.filter{ $0 == name }
        if student.count == 0 {
            return nil
        }
        return Array(student)[0]
    }
    
    func viewAverageScore(name: String) {
        guard isExist(name: name) else {
            InfoMessage.canNotFindStudent.printing(name: name)
            return
        }
        let student = list.filter{ $0 == name }
        Array(student)[0].showAverageScore()
    }
    
    mutating func addStudent(name: String) {
        if isExist(name: name) {
            InfoMessage.addFailure.printing(name: name)
            return
        }
        list.insert(Student(name: name))
        InfoMessage.addSuccess.printing(name: name)
    }
    
    mutating func deleteStudent(name: String) {
        guard let deleteTargetStudent = studentToBeDeleted(name: name) else {
            InfoMessage.canNotFindStudent.printing(name: name)
            return
        }
        list.remove(deleteTargetStudent)
        InfoMessage.deleteSuccess.printing(name: name)
    }
    
    mutating func addOrChangeGrade(name: String, subject: String, grade: String) {
        guard isExist(name: name) else {
            InfoMessage.canNotFindStudent.printing(name: name)
            return
        }
        let student = list.filter{ $0 == name }
        Array(student)[0].addOrChangeGrade(subject: subject, grade: grade)
    }
    
    mutating func deleteGrade(name: String, subject: String) {
        guard isExist(name: name) else {
            InfoMessage.canNotFindStudent.printing(name: name)
            return
        }
        let student = list.filter{ $0 == name }
        Array(student)[0].deleteGrade(subject: subject)
    }
}
