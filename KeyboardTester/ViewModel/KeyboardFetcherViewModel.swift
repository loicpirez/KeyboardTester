//
//  KeyboardFetcherViewModel.swift
//  KeyboardTester
//
//  Created by Loïc PIREZ on 07/07/2021.
//

import SwiftUI
import GameController
import Combine

class KeyboardFetcherViewModel: ObservableObject {
    @Published public var status: KeyboardStatus
    @Published public var buttons: [KeyboardButton]

    init() {
        self.status = KeyboardStatus()
        self.buttons = [
            KeyboardButton(keycode: GCKeyCode.upArrow.rawValue, name: "Up", type: KeyboardButtonType.direction),
            KeyboardButton(keycode: GCKeyCode.downArrow.rawValue, name: "Down", type: KeyboardButtonType.direction),
            KeyboardButton(keycode: GCKeyCode.leftArrow.rawValue, name: "Left", type: KeyboardButtonType.direction),
            KeyboardButton(keycode: GCKeyCode.rightArrow.rawValue, name: "Right", type: KeyboardButtonType.direction),
            KeyboardButton(keycode: GCKeyCode.returnOrEnter.rawValue, name: "Start", type: KeyboardButtonType.control),
            KeyboardButton(keycode: GCKeyCode.rightShift.rawValue, name: "Select", type: KeyboardButtonType.control),
            KeyboardButton(keycode: GCKeyCode.keyS.rawValue, name: "X", type: KeyboardButtonType.control),
            KeyboardButton(keycode: GCKeyCode.keyD.rawValue, name: "O", type: KeyboardButtonType.control),
            KeyboardButton(keycode: GCKeyCode.keyW.rawValue, name: "△", type: KeyboardButtonType.control),
            KeyboardButton(keycode: GCKeyCode.keyA.rawValue, name: "□", type: KeyboardButtonType.control)
        ]

        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.GCKeyboardDidConnect,
            object: nil,
            queue: OperationQueue.main
        ) { (_) in
            if let keyboard = GCKeyboard.coalesced?.keyboardInput {
                self.status.keyboardEnabled = true
                keyboard.keyChangedHandler = { (input, _, keyCode, pressed) in
                    let keyCodeDescription: String = keyCode.rawValue.description

                    if let pressedKey = self.buttons.enumerated().first(where: {$0.element.keycode == Int(keyCodeDescription) ?? 0}) {
                        self.buttons[pressedKey.offset].pressed = pressed
                    }

                    self.status.input = input.description
                }
            } else {
                self.status.keyboardEnabled = false
                self.status.input = ""
            }
        }

        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.GCKeyboardDidDisconnect,
            object: nil,
            queue: OperationQueue.main
        ) { (_) in
            self.status.keyboardEnabled = false
            self.status.input = ""
        }
    }
}
