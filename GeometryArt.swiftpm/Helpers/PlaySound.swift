//
//  PlaySound.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 19/02/24.
//

import AVFoundation
import Combine

class AudioPlayerManager: ObservableObject {
    private var audioEngine = AVAudioEngine()
    private var playerNode = AVAudioPlayerNode()
    
    var isPlaying = false
    
    enum Sounds:String {
        case A
        case ABN
        case B
        case Double
        case Double2
        case N
        case HeartBeat
        case Epic
    }
    
    func playSound(sound: Sounds, type: String) {
        
        switch sound {
        case .A:
            playerNode.volume = 0.6
        case .ABN:
            playerNode.volume = 0.5
        case .B:
            playerNode.volume = 0.9
        case .Double:
            playerNode.volume = 0.8
        case .Double2:
            playerNode.volume = 0.7
        case .N:
            playerNode.volume = 0.6
        case .HeartBeat:
            playerNode.volume = 1
        case .Epic:
            playerNode.volume = 0.7
        }
        
        guard let soundURL = Bundle.main.url(forResource: sound.rawValue, withExtension: type) else {
            print("Unable to find \(sound).\(type) in bundle")
            return
        }
        
        do {
            let audioFile = try AVAudioFile(forReading: soundURL)
            let audioFormat = audioFile.processingFormat
            
            // Connect nodes
            audioEngine.attach(playerNode)
            audioEngine.connect(playerNode, to: audioEngine.mainMixerNode, format: audioFormat)
            
            
            // Schedule file for playback
            playerNode.scheduleFile(audioFile, at: nil, completionCallbackType: .dataPlayedBack) {_ in
                self.isPlaying = false
            }
            
            
            // Start the engine
            try audioEngine.start()
            
            // Start playing
            playerNode.play()
            
            isPlaying = true
            
        } catch {
            print("Error playing sound: \(error)")
        }
    }
    
    func stopSound() {
        playerNode.stop()
        self.isPlaying = false
    }

}
