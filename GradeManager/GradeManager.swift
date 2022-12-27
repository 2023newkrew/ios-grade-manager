//
//  GradeManager.swift
//  GradeManager
//
//  Created by kakao on 2022/12/27.
//

import Foundation

class GradeManager {
    enum MenuType: String {
        case addStudent = "1"
        case deleteStudent = "2"
        case addScore = "3"
        case deleteScore = "4"
        case fetchScore = "5"
        case exitMenu = "x"
        case error = ""
    }
    
    enum Errors: Error {
        
        case duplicatedStudent
        
    }
    
    var students: [String: Student] = [:]
    
    
    func menu(command: String) -> MenuType? {
        return MenuType(rawValue: command)
    }
    
    private func receiveInput(message: MessageTemplate) -> String {
        print(message)
        return readLine() ?? ""
    }
    
    func run() {
    menuLoop: while let menu = self
        .menu(command: receiveInput(message: .selectMenu)) {
            switch menu {
            case .addStudent:
                break
            case .deleteStudent:
                break
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
    
    func addStudent(of name: String) {
        if isValid(name: name) {
            let student = Student(name: name)
            self.students[name] = student
        } else {
            print(template: .duplicatedStudent(name: name))
        }
    }
    
    func isValid(name: String) -> Bool {
        guard let _ = self.students[name] else {
            return true
        }
        return false
    }
    
    
}
