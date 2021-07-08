//
//  KeyboardButtonModel.swift
//  KeyboardTester
//
//  Created by Loïc PIREZ on 07/07/2021.
//

import Foundation

protocol KeyboardButtonInterface {
    var keycode: String { get set }
    var pressed: Bool { get set }
    var name: String { get set }
}

struct KeyboardButton: KeyboardButtonInterface {
    public var keycode: String
    public var name: String
    public var pressed: Bool = false

    init(keycode: String, name: String) {
        self.keycode = keycode
        self.name = name
    }
}

struct KeyboardButtons {
    var up: KeyboardButtonInterface
    var down: KeyboardButtonInterface
    var left: KeyboardButtonInterface
    var right: KeyboardButtonInterface
}
