//
//  ViewController.swift
//  Speech Command
//
//  Created by Anil Goktas on 12/27/20.
//

import Cocoa

#warning("Latest researches")
// https://www.google.com/search?client=safari&rls=en&q=SFSpeechRecognizer+tips&ie=UTF-8&oe=UTF-8
// https://littlebitesofcocoa.com/236-sfspeechrecognizer-basics
// https://www.reddit.com/r/swift/comments/efcna5/need_help_with_configuring_sfspeechrecognizer_for/

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
