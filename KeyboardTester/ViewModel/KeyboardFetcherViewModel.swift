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
    @Published public var buttons: KeyboardButtons

    init() {
        self.status = KeyboardStatus()
        self.buttons = KeyboardButtons(
            up: KeyboardButton(keycode: "82", name: "Up"),
            down: KeyboardButton(keycode: "81", name: "Down"),
            left: KeyboardButton(keycode: "80", name: "Left"),
            right: KeyboardButton(keycode: "79", name: "Right")
        )

        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.GCKeyboardDidConnect,
            object: nil,
            queue: OperationQueue.main
        ) { (_) in
            if let keyboard = GCKeyboard.coalesced?.keyboardInput {
                self.status.keyboardEnabled = true
                keyboard.keyChangedHandler = { (input, _, keyCode, pressed) in
                    let keyCodeDescription: String = keyCode.rawValue.description

                    switch keyCodeDescription {
                        case "82":
                            self.buttons.up.pressed = pressed
                        case "81":
                            self.buttons.down.pressed = pressed
                        case "80":
                            self.buttons.left.pressed = pressed
                        case "79":
                            self.buttons.right.pressed = pressed
                        default:
                            print("Key \(keyCodeDescription) not handled")
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
