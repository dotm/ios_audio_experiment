//
//  ViewController.swift
//  audio experiment
//
//  Created by Yoshua Elmaryono on 16/07/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var bgmPlayer: AVAudioPlayer!
    var sfxPlayer: AVAudioPlayer!
    
    @IBAction func playBGM(_ sender: UIButton) {
        bgmPlayer.play()
    }
    @IBAction func pauseBGM(_ sender: UIButton) {
        bgmPlayer.stop()
    }
    @IBAction func rewindBGM(_ sender: UIButton) {
        bgmPlayer.currentTime = 0
    }
    
    @IBAction func playSFX(_ sender: UIButton) {
        sfxPlayer.numberOfLoops = 0
        sfxPlayer.currentTime = 0
        sfxPlayer.play()
    }
    @IBAction func playSFX_withDelay(_ sender: UIButton) {
        sfxPlayer.numberOfLoops = 0
        sfxPlayer.currentTime = 0
        sfxPlayer.play(atTime: sfxPlayer.deviceCurrentTime + 3)
    }
    @IBAction func loopSFX(_ sender: UIButton) {
        sfxPlayer.numberOfLoops = -1
        sfxPlayer.currentTime = 0
        sfxPlayer.play()
    }
    @IBAction func stopSFX(_ sender: UIButton) {
        sfxPlayer.numberOfLoops = 0
        sfxPlayer.stop()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadPlayerForBGM()
        bgmPlayer.play()
        
        loadPlayerForSoundEffect()
    }

    func loadPlayerForBGM(){
        guard let backgroundMusicData = NSDataAsset(name: "bgm")?.data else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. */
            bgmPlayer = try AVAudioPlayer(data: backgroundMusicData, fileTypeHint: AVFileType.mp3.rawValue)
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadPlayerForSoundEffect(){
        guard let soundEffectData = NSDataAsset(name: "sound")?.data else { return }
        do {
            sfxPlayer = try AVAudioPlayer(data: soundEffectData, fileTypeHint: AVFileType.mp3.rawValue)
        } catch {
            print(error.localizedDescription)
        }
    }
}

