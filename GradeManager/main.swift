//
//  GradeManager - main.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import Foundation

enum InputError: Error {
    case invalidUserInput
    case invalidStudentGradeInfoInput
}

extension InputError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUserInput:// 바꿀 예정 invalidUserInput
            return "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
        case .invalidStudentGradeInfoInput:
            return "입력이 잘못되었습니다. 다시 확인해주세요."
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
    func viewAverageScore() -> Result<String, InputError> {
        guard let studentName = readLine() else {
            return .failure(.invalidUserInput)
        }
        return .success(studentName)
    }
    
    func addStudentGradeInfo() -> Result<(name: String, subject: String, grade: String), InputError> {
        guard let gradeInfo = readLine() else {
            return .failure(.invalidUserInput)
        }
        
        let validStudentInfoLength = 3
        let nameIndex = 0
        let subjectIndex = 1
        let gradeIndex = 2
        
        let studentInfo = gradeInfo.components(separatedBy: " ")
        guard studentInfo.count == validStudentInfoLength else {
            return .failure(.invalidStudentGradeInfoInput)
        }
                
        return .success((name: studentInfo[nameIndex], subject: studentInfo[subjectIndex], grade: studentInfo[gradeIndex]))
    }
    
    func deleteStudentGradeInfo() -> Result<(name: String, subject: String), InputError> {
        guard let gradeInfo = readLine() else {
            return .failure(.invalidUserInput)
        }
        
        let validStudentInfoLength = 2
        let nameIndex = 0
        let subjectIndex = 1
        
        let studentInfo = gradeInfo.components(separatedBy: " ")
        guard studentInfo.count == validStudentInfoLength else {
            return .failure(.invalidStudentGradeInfoInput)
        }
        
        return .success((name: studentInfo[nameIndex], studentInfo[subjectIndex]))
    }
    
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
    mutating func addStudent(name: String)
    mutating func deleteStudent(name: String)
    mutating func addOrChangeGrade(name: String, subject: String, grade: String)
    mutating func deleteGrade(name: String, subject: String)
    func viewAverageScore(name: String)
}

class Student: Hashable {
    private var name: String
    private var courseManager: CourseManager
    
    init(name: String) {
        self.name = name
        self.courseManager = CourseManager()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func == (lhs: Student, rhs: String) -> Bool {
        return lhs.name == rhs
    }
    
    func addOrChangeGrade(subject: String, grade: String) {
        courseManager.add(name: name, subject: subject, grade: grade)
    }
    
    func deleteGrade(subject: String) {
        courseManager.delete(name: name, subject: subject)
    }
    
    func showAverageScore() {        courseManager.showAverageScore()
    }
}

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
    
    func deleteTarget(name: String) -> Student? {
        for student in list {
            if student == name {
                return student
            }
        }
        return nil
    }
    
    func viewAverageScore(name: String) {
        guard isExist(name: name) else {
            InfoMessage.canNotFindStudent.printing(name: name)
            return
        }
        for student in list {
            if student == name {
                student.showAverageScore()
                return
            }
        }
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
        guard let deleteTargetStudent = deleteTarget(name: name) else {
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
        for student in list {
            if student == name {
                student.addOrChangeGrade(subject: subject, grade: grade)
                return
            }
        }
    }
    
    mutating func deleteGrade(name: String, subject: String) {
        guard isExist(name: name) else {
            InfoMessage.canNotFindStudent.printing(name: name)
            return
        }
        for student in list {
            if student == name {
                student.deleteGrade(subject: subject)
                return
            }
        }
    }
}

struct GradeManager {
    let inputManager = InputManager()
    private var studentManager: StudentManager = DefaultStudentManager()
    
    private enum InfoMessage: String {
        case guide = "원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료"
        case requireStudentNameToAdd = "추가할 학생의 이름을 입력해주세요"
        case requireStudentNameToDelete = "삭제할 학생의 이름을 입력해주세요"
        case requireStudentGradeToAddOrChange = "성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift A+"
        case requireStudentGradeToDelete = "성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요."
        case requireStudentWhoWantKnowScore = "평점을 알고싶은 학생의 이름을 입력해주세요."
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
        InfoMessage.requireStudentNameToAdd.printing()
        let studentNameResult = inputManager.getStudentName()
        switch studentNameResult {
        case .success(let studentName):
            studentManager.addStudent(name: studentName)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    mutating func deleteStudent() {
        InfoMessage.requireStudentNameToDelete.printing()
        let studentNameResult = inputManager.getStudentName()
        switch studentNameResult {
        case .success(let studentName):
            studentManager.deleteStudent(name: studentName)
        case . failure(let error):
            print(error.localizedDescription)
        }
    }
    
    mutating func addOrChangeGrade() {
        InfoMessage.requireStudentGradeToAddOrChange.printing()
        let studentGradeInfo = inputManager.addStudentGradeInfo()
        switch studentGradeInfo {
        case .success(let gradeInfo):
            studentManager.addOrChangeGrade(name: gradeInfo.name,
                                            subject: gradeInfo.subject,
                                            grade: gradeInfo.grade)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    mutating func deleteGrade() {
        InfoMessage.requireStudentGradeToDelete.printing()
        let studentGradeDeleteInfo = inputManager.deleteStudentGradeInfo()
        switch studentGradeDeleteInfo {
        case .success(let gradeInfo):
            studentManager.deleteGrade(name: gradeInfo.name,
                                       subject: gradeInfo.subject)
        case .failure(let error):
            print(error.localizedDescription)
        }
        
    }
    
    func viewAverageScore() {
        InfoMessage.requireStudentWhoWantKnowScore.printing()
        let studentName = inputManager.viewAverageScore()
        switch studentName {
        case .success(let name):
            studentManager.viewAverageScore(name: name)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    mutating private func operate(menu: Menu) {
        switch menu {
        case  .addStudent:
            addStudent()
        case .deleteStudent:
            deleteStudent()
        case .addOrChangeGrade:
            addOrChangeGrade()
        case .deleteGrade:
            deleteGrade()
        case .viewAverageScore:
            viewAverageScore()
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
