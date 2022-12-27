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
