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
final class SpeechAnalyzer: NSObject, SpeechAnalyzing {
    
    // MARK: - Properties
    
    var latestWord: String? { didSet { onWordUpdate?(latestWord) } }
    var onWordUpdate: ((String?) -> Void)?
    
    private let captureSession = AVCaptureSession()
    
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
    
    // MARK: - Life Cycle
    
    deinit {
        stop()
    }
    
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
        // Cancel previous task.
        currentTask?.cancel()
        currentTask = nil
        
        // Configure a request.
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.taskHint = .dictation
        request.requiresOnDeviceRecognition = true
        request.shouldReportPartialResults = true
        self.request = request
        
        // Configure new task.
        currentTask = recognizer.recognitionTask(with: request, delegate: self)
        
        guard let audioDevice = AVCaptureDevice.default(for: .audio) else {
            fatalError("Could not get capture device.")
        }
        
        guard let audioInput = try? AVCaptureDeviceInput(device: audioDevice) else {
            fatalError("Could not create input device.")
        }
        
        guard captureSession.canAddInput(audioInput) else {
            fatalError("Could not add input device")
        }
        captureSession.addInput(audioInput)
        
        let audioOutput = AVCaptureAudioDataOutput()
        let queue = DispatchQueue(label: "speech-analyzer", qos: .utility)
        audioOutput.setSampleBufferDelegate(self, queue: queue)
        
        guard captureSession.canAddOutput(audioOutput) else {
            fatalError("Could not add audio output")
        }
        
        captureSession.addOutput(audioOutput)
//        audioOutput.connection(with: .audio)
        captureSession.startRunning()
    }
    
    func stop() {
        captureSession.stopRunning()
        
        request?.endAudio()
        request = nil
        
        currentTask?.cancel()
        currentTask = nil
    }
    
}

extension SpeechAnalyzer: AVCaptureAudioDataOutputSampleBufferDelegate {
    
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        request?.appendAudioSampleBuffer(sampleBuffer)
    }
    
}

extension SpeechAnalyzer: SFSpeechRecognitionTaskDelegate {
    
    func speechRecognitionDidDetectSpeech(_ task: SFSpeechRecognitionTask) {
        print("--> speechRecognitionDidDetectSpeech")
    }
    
    func speechRecognitionTask(
        _ task: SFSpeechRecognitionTask,
        didHypothesizeTranscription transcription: SFTranscription
    ) {
        print("--> didHypothesizeTranscription")
        print(transcription)
        
        guard let lastSegment = transcription.segments.last else {
            DispatchQueue.main.async {
                self.latestWord = nil
            }
            return
        }
        
        let lowercased = lastSegment.substring.lowercased(with: Current.locale)
        
        if let number = stringNumberFormatter.number(from: lowercased) {
            let numberStringValue = number.stringValue
            DispatchQueue.main.async {
                self.latestWord = numberStringValue
            }
        } else {
            DispatchQueue.main.async {
                self.latestWord = lowercased
            }
        }
    }
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishRecognition recognitionResult: SFSpeechRecognitionResult) {
        print("--> didFinishRecognition")
    }
    
    func speechRecognitionTaskFinishedReadingAudio(_ task: SFSpeechRecognitionTask) {
        print("--> speechRecognitionTaskFinishedReadingAudio")
    }
    
    func speechRecognitionTaskWasCancelled(_ task: SFSpeechRecognitionTask) {
        print("--> speechRecognitionTaskWasCancelled")
    }
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishSuccessfully successfully: Bool) {
        #warning("it seems to be deactivated after 1 minute, so we have to restart when this gets called")
        print("--> didFinishSuccessfully:", successfully)
        self.start()
    }
    
}
