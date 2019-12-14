//
//  ViewController.swift
//  MediaExercise
//
//  Created by Anna Niukkanen on 16/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import AVKit

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer?
    var player: AVPlayer?
    var imageTaken: AVPlayer?
    
    @IBAction func startRecord(_ sender: Any) {
        // not recording yet
        if !audioRecorder.isRecording {
            // create audio session
            let audioSession = AVAudioSession.sharedInstance()
            // try to start recording
            do {
                try audioSession.setActive(true)
                audioRecorder.record()
                print("Start recording")
            } catch {
                print("Recording error")
                print(error)
            }
        }
    }
    
    @IBAction func stopRecord(_ sender: Any) {
        if audioRecorder.isRecording {
            audioRecorder.stop()
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(false)
            } catch {
                print(error)
            }
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        var message : UIAlertController
        if flag {
            message = UIAlertController(title: "Recording", message: "Audio reording finished successfully.", preferredStyle: .alert)
        } else {
            message = UIAlertController(title: "Recording", message: "There was problem with save audio recording", preferredStyle: .alert)
        }
        message.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(message, animated: true, completion: nil)
    }
    
    @IBAction func startPlay(_ sender: Any) {
        // if application is not recording
        if !audioRecorder.isRecording {
            // get audio player
            guard let player = try? AVAudioPlayer(contentsOf: audioRecorder.url) else {
                print("AVAudioPlayer initialization failed!")
                return
            }
            // assing player to class variable and start playing
            audioPlayer = player
            audioPlayer?.delegate = self
            audioPlayer?.play()
        }
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let message = UIAlertController(title: "AudioPlayer", message: "Finished playing audio.", preferredStyle: .alert)
        message.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(message, animated: true, completion: nil)
    }
    
    
    @IBAction func loadImage(_ sender: Any) {
        // checking that photo library is available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // create image picker controller
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .photoLibrary
            // image picker delegate
            imagePickerController.delegate = self
            // open image picker
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func takePicture(_ sender: Any) {
        // checking that camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // create image picker controller
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .camera
            //imagePickerController.cameraCaptureMode = .photo
            // image picker delegate
            imagePickerController.delegate = self
            // open image picker
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            print("Camera is not available!")
        }
    }
    
    // this function will be called after photo has been selected
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // find selected photo
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // show it in image view
            imageView.image = selectedImage
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        }
        // photo taken
      //  imageTaken = true
        // remove image picker
        dismiss(animated: true, completion: nil)
        
        // check that selected file is Video file
        guard
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            else {
                return
        }
        
        // find selected video
        if let selectedVideo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // show it in image view
            imageView.image = selectedVideo
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        }
        // remove video picker
        dismiss(animated: true, completion: nil)
        // create av player and controller
        let player = AVPlayer(url: url)
        let playerController = AVPlayerViewController()
        playerController.player = player
        // show video
        self.present(playerController, animated: true, completion: nil)
    }
    
    @IBAction func playVideo(_ sender: Any) {
        // checking that photo library is available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // create image picker controller
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.mediaTypes = [kUTTypeMovie as String]
            // image picker delegate
            imagePickerController.delegate = self
            // open image picker
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func recordVideo(_ sender: Any) {
        // checking that camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // create image picker controller
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .camera
            imagePickerController.mediaTypes = [kUTTypeMovie as String]
            // image picker delegate
            imagePickerController.delegate = self
            // open image picker
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // save audio to document directory, check it first (is it available)
        // -> search document directory with FileManager
        guard let directory = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else {
            let message = UIAlertController(title: "Error", message: "Can't use document directory for recording audio", preferredStyle: .alert)
            message.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(message, animated: true, completion: nil)
            return
        }
        // set audio file
        let audioFile = directory.appendingPathComponent("AudioFile.m4a")
        // set audio session
        let audioSession = AVAudioSession.sharedInstance()
        // define settings
        do {
            // play and record
            try audioSession.setCategory(.playAndRecord, mode: .default)
            let recordSettings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
            audioRecorder.delegate = self
            // create audio file and ready for recording
            audioRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }


}

