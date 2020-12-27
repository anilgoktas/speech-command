//
//  SpeechAnalyzer.swift
//  Speech Command
//
//  Created by Anil Goktas on 12/27/20.
//

import Foundation
import Speech

protocol SpeechAnalyzing: AnyObject {
    var latestWord: String? { get }
    var onWordUpdate: ((String?) -> Void)? { get set }
    
    func authorize()
    func start()
    func stop()
}

/// - Note: [Reference](https://heartbeat.fritz.ai/speech-recognition-and-speech-synthesis-on-ios-with-swift-d1a63e469cd9)
final class SpeechAnalyzer: SpeechAnalyzing {
    
    // MARK: - Properties
    
    var latestWord: String? { didSet { onWordUpdate?(latestWord) } }
    var onWordUpdate: ((String?) -> Void)?
    
    private let audioEngine = AVAudioEngine()
    private let recognizer: SFSpeechRecognizer = {
        let recognizer = SFSpeechRecognizer(locale: Current.locale)!
        recognizer.defaultTaskHint = .dictation
        let queue = OperationQueue()
        queue.qualityOfService = .utility
        queue.maxConcurrentOperationCount = 1
        recognizer.queue = queue
        return recognizer
    }()
    
    private let stringNumberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Current.locale
        formatter.numberStyle = .spellOut
        return formatter
    }()
    
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var currentTask: SFSpeechRecognitionTask?
    
    // MARK: - Analyzing
    
    func authorize() {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                if status == .authorized {
                    print("SFSpeechRecognizer is authorized.")
                } else {
                    print("Error: SFSpeechRecognizer is not authorized.")
                }
            }
        }
        
        AVCaptureDevice.requestAccess(for: .audio) { hasGranted in
            DispatchQueue.main.async {
                if hasGranted {
                    print("AVCaptureDevice is authorized.")
                } else {
                    print("Error: AVCaptureDevice is not authorized.")
                }
            }
        }
    }
    
    func start() {
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.taskHint = .dictation
        request.requiresOnDeviceRecognition = true
        request.shouldReportPartialResults = true
        self.request = request

        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] buffer, _ in
            self?.request?.append(buffer)
        }

        do {
            audioEngine.prepare()
            try audioEngine.start()
        } catch {
            fatalError(error.localizedDescription)
        }
        
        // Indicates not available on `macOS`.
//        if !recognizer.isAvailable {
//            fatalError("SFSpeechRecognizer is not available")
//        }
        
        currentTask = recognizer.recognitionTask(with: request) { [weak self] result, error in
            guard let result = result else {
                print("There was an error: " + String(describing: error))
                DispatchQueue.main.async {
                    self?.latestWord = nil
                }
                return
            }
            
            // Lowercase the formatted string in order to match.
            let formattedString = result.bestTranscription.formattedString
            let lowercased = formattedString.lowercased(with: Current.locale)

            if let number = self?.stringNumberFormatter.number(from: lowercased) {
                let numberStringValue = number.stringValue
                DispatchQueue.main.async {
                    self?.latestWord = numberStringValue
                    
                    // Restart for faster processing.
                    self?.stop()
                    self?.start()
                }
            } else {
                DispatchQueue.main.async {
                    self?.stop()
                    self?.start()
                }
            }
        }
    }
    
    func stop() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        
        request?.endAudio()
        request = nil
        
        currentTask?.cancel()
        currentTask = nil
    }
    
}
