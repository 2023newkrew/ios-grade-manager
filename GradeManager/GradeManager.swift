//
//  GradeManager.swift
//  GradeManager
//
//  Created by kakao on 2022/12/27.
//

import Foundation

class GradeManager {
    private(set) var students: [String: Student] = [:]
    
    func menu(command: String) -> MenuType {
        return MenuType(rawValue: command) ?? .error
    }
    
    func run() {
    menuLoop: while let input = self.receiveInput(message: .selectMenu) {
        let menu = self.menu(command: input)
        switch menu {
        case .addStudent:
            let name = self.receiveInput(message: .inputStudent)
            self.addStudent(of: name)
        case .deleteStudent:
            let name = self.receiveInput(message: .deleteStudent)
            self.deleteStudent(of: name)
        case .addScore:
            let scoreFormat = self.receiveInput(message: .inputScore)
            self.addScore(format: scoreFormat)
        case .deleteScore:
            let scoreFormat = self.receiveInput(message: .deleteScore)
            self.deleteScore(format: scoreFormat)
        case .fetchScore:
            let name = self.receiveInput(message: .queryStudentScores)
            self.queryStudentScores(of: name)
        case .exitMenu:
            print(template: .exitProgram)
            break menuLoop
        case .error:
            print(template: .wrongMenu)
        }
    }
    }
    
    func addStudent(of name: String?) {
        guard let name else {
            return
        }
        
        if !self.isValid(studentName: name) {
            print(template: .invalidInput)
            return
        }
        
        if self.isExisting(name: name) {
            print(template: .duplicatedStudent(name: name))
            return
        }
        let student = Student(name: name)
        self.students[name] = student
        print(template: .completeAddStudent(name: name))
    }
    
    func deleteStudent(of name: String?) {
        guard let name else {
            return
        }
        
        if !self.isValid(studentName: name) {
            print(template: .invalidInput)
            return
        }
        
        guard self.isExisting(name: name) else {
            print(template: .notExistStudent(name: name))
            return
        }
        self.students[name] = nil
        print(template: .completeDeleteStudent(name: name))
    }
    
    func addScore(format scoreFormat: String?) {
        guard let scoreFormat,
              let (name, subject, grade) = scoreAddComponents(of: scoreFormat)
        else {
            print(template: .invalidInput)
            return
        }
        
        guard var student = students[name] else {
            print(template: .notExistStudent(name: name))
            return
        }
        
        student.addScore(subject: subject, grade: grade)
        self.students[name] = student
        print(template: .completeAddScore(name: name, subject: subject, grade: grade))
    }
    
    func deleteScore(format scoreFormat: String?) {
        guard let scoreFormat,
              let (name, subject) = scoreDeleteComponents(of: scoreFormat)
        else {
            print(template: .invalidInput)
            return
        }
        
        guard var student = students[name] else {
            print(template: .notExistStudent(name: name))
            return
        }
        
        guard student.scores[subject] != nil else {
            print(template: .notFoundSubject)
            return
        }
        
        student.deleteScore(subject: subject)
        self.students[name] = student
        print(template: .completeDeleteScore(name: name, subject: subject))
    }
    
    func queryStudentScores(of name: String?) {
        guard let name else {
            return
        }
        
        if !self.isValid(studentName: name) {
            print(template: .invalidInput)
            return
        }
        
        guard let student = students[name] else {
            print(template: .notExistStudent(name: name))
            return
        }
        
        if student.scores.count == 0 {
            print(template: .emptyScores)
            return
        }
        
        let average = student.scores
            .values
            .map { $0.score / Double(student.scores.count) }
            .reduce(0.0, +)

        let roundedAverage = round(average * 100) / 100.0
        print(template: .studentStatus(scores: student.scores))
        print(template: .studentAverageScore(roundedAverage.description))
    }
    
    private func isValid(studentName: String) -> Bool {
        return !studentName.isEmpty
    }
    
    private func scoreAddComponents(of scoreFormat: String)
    -> (name: String, subject: String, grade: Grade)? {
        let scoreFormatArray = scoreFormat.components(separatedBy: " ")
        
        if scoreFormatArray.count != 3 {
            return nil
        }
        
        guard let grade = Grade(rawValue: scoreFormatArray[2]) else {
            return nil
        }
        
        let name = scoreFormatArray[0]
        let subject = scoreFormatArray[1]
        
        return (name, subject, grade)
    }
    
    private func scoreDeleteComponents(of scoreFormat: String)
    -> (name: String, subject: String)? {
        let scoreFormatArray = scoreFormat.components(separatedBy: " ")
        
        if scoreFormatArray.count != 2 {
            return nil
        }
        
        let name = scoreFormatArray[0]
        let subject = scoreFormatArray[1]
        
        return (name, subject)
    }
    
    private func isExisting(name: String) -> Bool {
        guard let _ = self.students[name] else {
            return false
        }
        return true
    }
    
    private func receiveInput(message: MessageTemplate) -> String? {
        print(message)
        return readLine()
    }
}

extension GradeManager {
    enum MenuType: String {
        case addStudent = "1"
        case deleteStudent = "2"
        case addScore = "3"
        case deleteScore = "4"
        case fetchScore = "5"
        case exitMenu = "x"
        case error = ""
    }
}
