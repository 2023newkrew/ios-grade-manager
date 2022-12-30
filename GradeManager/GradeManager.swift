//
//  GradeManager.swift
//  GradeManager
//
//  Created by kakao on 2022/12/30.
//

import Foundation

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
