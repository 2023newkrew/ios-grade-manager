//
//  GradeManager.swift
//  GradeManager
//
//  Created by kakao on 2022/12/27.
//

import Foundation

class GradeManager {
    var students: [String: Student] = [:]
    
    func menu(command: String) -> MenuType {
        return MenuType(rawValue: command) ?? .error
    }
    
    func run() {
    menuLoop: while let input = receiveInput(message: .selectMenu) {
            let menu = self.menu(command: input)
            switch menu {
            case .addStudent:
                let name = receiveInput(message: .inputStudent)
                addStudent(of: name)
            case .deleteStudent:
                let name = receiveInput(message: .deleteStudent)
                deleteStudent(of: name)
            case .addScore:
                break
            case .deleteScore:
                break
            case .fetchScore:
                break
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
        
        if !isValid(studentName: name) {
            print(template: .invalidStudentName)
            return
        }
        
        if isExisting(name: name) {
            print(template: .duplicatedStudent(name: name))
            return
        }
        let student = Student(name: name)
        self.students[name] = student
    }
    
    func deleteStudent(of name: String?) {
        guard let name else {
            return
        }
        
        if !isValid(studentName: name) {
            print(template: .invalidStudentName)
            return
        }
        
        guard isExisting(name: name) else {
            print(template: .notExistStudent(name: name))
            return
        }
        self.students[name] = nil
    
    func isValid(studentName: String) -> Bool {
        return !studentName.isEmpty
    }
    
    func isExisting(name: String) -> Bool {
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
