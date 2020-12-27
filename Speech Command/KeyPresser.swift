//
//  KeyPresser.swift
//  Speech Command
//
//  Created by Anil Goktas on 12/27/20.
//

import Foundation

protocol KeyPressing {
    func press(_ string: String)
}

/// - Note: [Detailed Resource](https://www.programmersought.com/article/20392219070/)
final class KeyPresser: KeyPressing {
    
    // MARK: - Properties
    
    private let keyCodeConverter = KeyCodeConverter()
    
    // MARK: - Pressing
    
    func press(_ string: String) {
        guard let keyCode = keyCodeConverter.keyCode(with: string) else {
            return
        }
        print("KeyCode:", keyCode)
        pressKey(code: keyCode)
    }
    
}

// MARK: - Keyboard Interaction

extension KeyPresser {
    
    /// Presses or releases a key with the given key code.
    /// - Parameters:
    ///   - keyDown: `true` for pressing, `false` for releasing the key.
    private func pressKeyboard(keyCode: CGKeyCode, keyDown: Bool) {
        let source = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)
        let event = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: keyDown)
        event?.post(tap: CGEventTapLocation.cghidEventTap)
    }
    
    /// Presses and releases the key as the user interaction.
    private func pressKey(code: CGKeyCode) {
        pressKeyboard(keyCode: code, keyDown: true)
        pressKeyboard(keyCode: code, keyDown: false)
    }
    
}
