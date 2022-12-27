//
//  GradeManager.swift
//  GradeManager
//
//  Created by kakao on 2022/12/27.
//

import Foundation

class GradeManager {
    enum MenuType: String {
        case addStudent = "1"
        case deleteStudent = "2"
        case addScore = "3"
        case deleteScore = "4"
        case fetchScore = "5"
        case exitMenu = "x"
        case error = ""
    }
    

    func menu(command: String) -> MenuType? {
        return MenuType(rawValue: command)
    }
    
    private func receiveInput(message: MessageTemplate) -> String {
        print(message)
        return readLine() ?? ""
    }
    
    func run() {
    menuLoop: while let menu = self
        .menu(command: receiveInput(message: .selectMenu)) {
            switch menu {
            case .addStudent:
                break
            case .deleteStudent:
                break
            case .addScore:
                break
            case .deleteScore:
                break
            case .fetchScore:
                break
            case .exitMenu:
                print(template: .exitProgram)
                break menuLoop
            case .error:
                print(template: .wrongMenu)
            }
        }
    }
    
    
}
