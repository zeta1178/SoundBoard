//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by Michael Cruz on 9/21/16.
//  Copyright © 2016 MIchael Cruz. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
        
        
    }
    
    func setupRecorder() {
        
        do {
            //Create an Audio Session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            //Create URL for the audio File
            
            let basePath: String  = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print("#######################")
            print(audioURL)
            print("#######################")
            
            //Create settings for audio recorder
            
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            //Create audioRecorder object
            
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder!.prepareToRecord()
        
        } catch let error as NSError {
                print(error)
        }
        
        
        
    }
    
    
    
    @IBAction func recordTapped(_ sender: AnyObject) {
    
        if audioRecorder!.isRecording {
            //Stop the recording
            
            audioRecorder?.stop()
            
            //Change button title to record
            
            recordButton.setTitle("Record", for: .normal)
            
        } else {
            //Start the recording
            
            audioRecorder?.record()
            
            //Change Button title to stop
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    
    @IBAction func playTapped(_ sender: AnyObject) {
    }
    
    
    @IBAction func addTapped(_ sender: AnyObject) {
    }
    
    
}
