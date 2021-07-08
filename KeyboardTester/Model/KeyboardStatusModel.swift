//
//  KeyboardStatusModel.swift
//  KeyboardTester
//
//  Created by Loïc PIREZ on 07/07/2021.
//
import Foundation
import GameController

protocol KeyboardStatusInterface {
    var input: String { get set }
    var keyboardEnabled: Bool { get set }
}

struct KeyboardStatus: KeyboardStatusInterface {
    var input: String
    var keyboardEnabled: Bool

    init() {
        input = ""
        keyboardEnabled = false
    }
}
