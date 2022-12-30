//
//  Student.swift
//  GradeManager
//
//  Created by kakao on 2022/12/30.
//

import Foundation

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
    
    func showAverageScore() {
        courseManager.showAverageScore()
    }
}
