//
//  ViewController.swift
//  Speech Command
//
//  Created by Anil Goktas on 12/27/20.
//

import Cocoa

final class ViewController: NSViewController {
    
    @IBOutlet weak var latestTextField: NSTextField!
    
    private let speechAnalyzer: SpeechAnalyzing = SpeechAnalyzer()
    private let keyPresser: KeyPressing = KeyPresser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latestTextField.stringValue = "No Command Yet."
        
        speechAnalyzer.onWordUpdate = { [weak self] word in
            if let word = word {
                self?.latestTextField.stringValue = word
                self?.keyPresser.press(word)
            } else {
                self?.latestTextField.stringValue = "Not Found!"
            }
        }
    }
    
    @IBAction func authorize(_ sender: Any) {
        speechAnalyzer.authorize()
    }
    
    @IBAction func start(_ sender: Any) {
        speechAnalyzer.start()
    }
    
    @IBAction func stop(_ sender: Any) {
        speechAnalyzer.stop()
    }
    
}
