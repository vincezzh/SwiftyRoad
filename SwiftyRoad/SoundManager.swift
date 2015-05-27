//
//  SoundManager.swift
//  Plane
//
//  Created by Heber Sheffield on 11/20/14.
//  Copyright (c) 2014 Polished Play, LLC. All rights reserved.
//

import UIKit
import AVFoundation

let kSoundBackgroundMusic = "Cruise.mp3"
let kSoundCar = "car.mp3"
let kSoundBoom = "boom.m4a"
let kSoundSuccess = "success.m4a"


class SoundManager: NSObject {
    var soundPlayers = Dictionary<String, AVAudioPlayer>()
    
    func startLoopingSound(fileName: String, volume: Float) {
        let player = playerForFile(fileName)
        player.volume = volume
        player.numberOfLoops = -1
        player.play()
    }
    
    func stopLoopingSound(fileName: String) {
        playerForFile(fileName).stop()
    }
    
    func playSound(fileName: String) {
        let player = playerForFile(fileName)
        player.play()
    }
    
   
    
    private func playerForFile(fileName: String) -> AVAudioPlayer {
        if let existingPlayer = soundPlayers[fileName] {
            return existingPlayer
        }
        let fileURL = NSBundle.mainBundle().URLForResource(fileName, withExtension: nil)
        
        let newPlayer = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
        soundPlayers[fileName] = newPlayer
        return newPlayer
    }
}
