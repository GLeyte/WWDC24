//
//  PlaySound.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 19/02/24.
//

import AVFoundation

class SoundManager {
    
    static let instance = SoundManager()
    
    var audioPlayer: AVAudioPlayer?
    
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
