//
//  GradeManager - main.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import Foundation

enum InputError: Error {
    case invalidUserInput
}

extension InputError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUserInput:// 바꿀 예정 invalidUserInput
            return "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
        }
    }
}

enum Menu: String {
    case addStudent = "1"
    case deleteStudent = "2"
    case addOrChangeGrade = "3"
    case deleteGrade = "4"
    case viewAverageScore = "5"
    case exitGradeManager = "X"
}

struct InputManager {
    func choiceMenu() -> Result<Menu, InputError> { // 1,2,3,4,5, X, 얘네를 제외하고 다른 문자가 들어가면
        guard let choice = readLine(), let menu = Menu(rawValue: choice) else {
            return .failure(.invalidUserInput)
        }
        return .success(menu)
    }
    
    func getStudentName() -> Result<String, InputError> {
        guard let name = readLine() else {
            return .failure(.invalidUserInput)
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
    private enum InfoMessage: String {
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
    
    var numberOfStudent: Int {
        return self.list.count
    }
    
    func isDuplicate(name: String) -> Bool {
        return list.contains(Student(name: name))
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
    
    private enum InfoMessage: String {
        case guide = "원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료"
        case add = "추가할 학생의 이름을 입력해주세요"
        case delete = "삭제할 학생의 이름을 입력해주세요"
        case exit = "프로그램을 종료합니다..."
        
        func printing() {
            print(self.rawValue)
        }
    }
        
    func menuChoice() -> Menu? {
        let input = inputManager.choiceMenu()
        switch input {
        case .success(let menu):
            return menu
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
    
    mutating private func operate(menu: Menu) {
        switch menu {
        case  .addStudent:
            addStudent()
        case .deleteStudent:
            deleteStudent()
        default:
            break
        }
    }
    
    mutating func run() {
        var canOperate: Bool = true
        while canOperate {
            InfoMessage.guide.printing()
            guard let menu = menuChoice() else {
                continue
            }
            
            if menu == .exitGradeManager {
                InfoMessage.exit.printing()
                canOperate = false
                break
            }

            operate(menu: menu)
        }
    }
}

var gradeManager = GradeManager()
gradeManager.run()
