//
//  InputManager.swift
//  GradeManager
//
//  Created by kakao on 2022/12/30.
//

import Foundation

enum Menu: String {
    case addStudent = "1"
    case deleteStudent = "2"
    case addOrChangeGrade = "3"
    case deleteGrade = "4"
    case viewAverageScore = "5"
    case exitGradeManager = "X"
}

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
