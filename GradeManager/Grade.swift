//
//  Grade.swift
//  GradeManager
//
//  Created by john-lim on 2022/12/29.
//

import Foundation

enum Grade: String {
    case APlus = "A+"
    case AZero = "A0"
    case BPlus = "B+"
    case BZero = "B0"
    case CPlus = "C+"
    case CZero = "C0"
    case DPlus = "D+"
    case DZero = "D0"
    case F = "F"
    
    var score: Double {
        switch self {
        case .APlus:
            return 4.5
        case .AZero:
            return 4.0
        case .BPlus:
            return 3.5
        case .BZero:
            return 3.0
        case .CPlus:
            return 2.5
        case .CZero:
            return 2.0
        case .DPlus:
            return 1.5
        case .DZero:
            return 1.0
        case .F:
            return 0
        }
    }
}
