//
//  GradeManager - main.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import Foundation

enum InputError: Error {
    case null
    case wrong
}

extension InputError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .null:
            return "입력에 문제가 있습니다. 다시 입력해주세요."
        case .wrong:
            return "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
        }
    }
}

struct InputManager {
    func choiceMenu() -> Result<String, InputError> {
        guard let choice = readLine() else {
            return .failure(.null)
        }
        
        switch choice {
        case "1", "2", "3", "4", "5", "X":
            return .success(choice)
        default:
            return .failure(.wrong)
        }
    }
    
    func getStudentName() -> Result<String, InputError> {
        guard let name = readLine() else {
            return .failure(.null)
        }
        return .success(name)
    }
}

protocol StudentManager {
    mutating func add(name: String)
    mutating func delete(name: String)
}

struct Student: Hashable {
    var name: String
    
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func == (lhs: Student, rhs: String) -> Bool {
        return lhs.name == rhs
    }
}

struct DefaultStudentManager: StudentManager {
    enum InfoMessage: String {
        case addSuccess = " 학생을 추가했습니다."
        case addFailure = "입력이 잘못되었습니다. 다시 확인해주세요."
        case deleteSuccess = "학생을 삭제하였습니다."
        case deleteFailure = " 학생을 찾지 못했습니다."
        
        func printing(name: String) {
            switch self {
            case .addSuccess, .deleteFailure:
                print(name, terminator: "")
                print(self.rawValue)
            default:
                print(self.rawValue)
            }
        }
    }
    
    private var list = Set<Student>()
    
    func isDuplicate(name: String) -> Bool {
        for student in list {
            if student == name {
                return true
            }
        }
        return false
    }
    
    func deleteTarget(name: String) -> Student? {
        for student in list {
            if student == name {
                return student
            }
        }
        return nil
    }
    
    mutating func add(name: String) {
        if isDuplicate(name: name) {
            InfoMessage.addFailure.printing(name: name)
            return
        }
        list.insert(Student(name: name))
        InfoMessage.addSuccess.printing(name: name)
    }
    
    mutating func delete(name: String) {
        guard let deleteTargetStudent = deleteTarget(name: name) else {
            InfoMessage.deleteFailure.printing(name: name)
            return
        }
        list.remove(deleteTargetStudent)
        InfoMessage.deleteSuccess.printing(name: name)
    }
}

struct GradeManager {
    let inputManager = InputManager()
    private var studentManager: StudentManager = DefaultStudentManager()
    
    enum InfoMessage: String {
        case guide = "원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료"
        case add = "추가할 학생의 이름을 입력해주세요"
        case delete = "삭제할 학생의 이름을 입력해주세요"
        case exit = "프로그램을 종료합니다..."
        
        func printing() {
            print(self.rawValue)
        }
    }
    
    func menuChoice() -> String? {
        let input = inputManager.choiceMenu()
        switch input {
        case .success(let data):
            return data
        case .failure(let error):
            print(error.localizedDescription)
            return nil
        }
    }
    
    mutating func addStudent() {
        InfoMessage.add.printing()
        let studentNameResult = inputManager.getStudentName()
        switch studentNameResult {
        case .success(let studentName):
            studentManager.add(name: studentName)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    mutating func deleteStudent() {
        InfoMessage.delete.printing()
        let studentNameResult = inputManager.getStudentName()
        switch studentNameResult {
        case .success(let studentName):
            studentManager.delete(name: studentName)
        case . failure(let error):
            print(error.localizedDescription)
        }
    }
    
    mutating func operate(menu: String) {
        switch menu {
        case "1":
            addStudent()
        case "2":
            deleteStudent()
        default:
            break
        }
    }
    
    mutating func run() {
        while true {
            InfoMessage.guide.printing()
            guard let menu = menuChoice() else {
                continue
            }
            if menu == "X" {
                InfoMessage.exit.printing()
                break
            }
            operate(menu: menu)
        }
    }
}

var gradeManager = GradeManager()
gradeManager.run()
