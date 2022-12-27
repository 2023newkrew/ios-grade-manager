//
//  GradeManager.swift
//  GradeManager
//
//  Created by kakao on 2022/12/27.
//

import Foundation

class GradeManager {
    var students: [String: Student] = [:]
    
    func menu(command: String) -> MenuType? {
        return MenuType(rawValue: command)
    }
    
    func run() {
    menuLoop: while let menu = self
        .menu(command: receiveInput(message: .selectMenu)) {
            switch menu {
            case .addStudent:
                let input = receiveInput(message: .inputStudent)
                addStudent(of: input)
            case .deleteStudent:
                let input = receiveInput(message: .deleteStudent)
                deleteStudent(of: input)
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
        if isExisting(name: name) {
            print(template: .duplicatedStudent(name: name))
            return
        }
        let student = Student(name: name)
        self.students[name] = student
    }
    
    func deleteStudent(of name: String) {
        guard isExisting(name: name) else {
            print(template: .notExistStudent(name: name))
            return
        }
        self.students[name] = nil
    }
    
    func isExisting(name: String) -> Bool {
        guard let _ = self.students[name] else {
            return false
        }
        return true
    }
    
    private func receiveInput(message: MessageTemplate) -> String {
        print(message)
        return readLine() ?? ""
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
