//
//  KeyboardButtonModel.swift
//  KeyboardTester
//
//  Created by Loïc PIREZ on 07/07/2021.
//

import Foundation

enum KeyboardButtonType: String, CaseIterable {
    case direction = "Direction"
    case control = "Control"
}

protocol KeyboardButtonInterface {
    var keycode: Int { get set }
    var pressed: Bool { get set }
    var name: String { get set }
    var type: KeyboardButtonType { get set }
}

struct KeyboardButton: KeyboardButtonInterface {
    public var keycode: Int
    public var name: String
    public var type: KeyboardButtonType
    public var pressed: Bool = false

    init(keycode: Int, name: String, type: KeyboardButtonType) {
        self.keycode = keycode
        self.name = name
        self.type = type
    }
}
