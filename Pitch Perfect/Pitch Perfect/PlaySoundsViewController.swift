//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Joe Glandorf (jglandorf@gmail.com) on 3/21/15.
//  Copyright (c) 2015 Mentis Avis. All rights reserved.
//  Portions from https://www.udacity.com/course/nd003 Copyright (c) 2014, 2015 Udacity
//

import UIKit
import AVFoundation

// Works with the RecordSoundsViewController class.
// Plays back with sound effects.
class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        stopAudio()
        audioPlayer.rate = 1.5 // play X times faster
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        stopAudio()
        audioPlayer.rate = 0.5 // play X times slower
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)  // increase pitch by N 'cents'
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)  // decrease pitch by N 'cents'
    }
    
    func stopAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    // pitch is -2400 to +2400 'cents'
    func playAudioWithVariablePitch(pitch: Float){
        stopAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
}
