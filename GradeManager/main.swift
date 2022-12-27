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

struct GradeManager {
    enum InfoMessage: String {
        case guide = "원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료"
        
        func printing() {
            print(self.rawValue)
        }
    }
    
    func menuChoice() -> Result<String, InputError> {
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
}
