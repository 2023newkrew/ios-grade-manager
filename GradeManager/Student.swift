//
//  Student.swift
//  GradeManager
//
//  Created by kakao on 2022/12/27.
//

import Foundation

struct Student {
    let name: String
    private(set) var scores: [String: Grade] = [:]
    
    mutating func addScore(subject: String, grade: Grade) {
        self.scores[subject] = grade
    }
    
    mutating func deleteScore(subject: String) {
        self.scores[subject] = nil
    }
}
