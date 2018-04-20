//
//  ThirdViewController.swift
//  Rapp2
//
//  Created by Victor on 2018-04-19.
//  Copyright © 2018 Victor Bak. All rights reserved.
//

import UIKit
import AVFoundation


class ThirdViewController : UIViewController, AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var recordingPlayer : AVAudioPlayer!
    
    var numberOfRecords : Int = 0
    

    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func record(_ sender: Any)
    {
        
        //Check if we have an active recorder
        if audioRecorder == nil
        {
            numberOfRecords += 1
            let filename = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
            
            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
            //Start audio recording
            do
            {
                audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
                
                buttonLabel.setTitle("Stop Recording", for: .normal)
            }
            catch
            {
                displayAlert(title: "Ups!", message: "Recording failed")
            }
        }
        else
        {
            //Stopping recording
            audioRecorder.stop()
            audioRecorder = nil
            
            UserDefaults.standard.set(numberOfRecords, forKey: "myNumber")
            myTableView.reloadData()
            
            
            buttonLabel.setTitle("Start Recording", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingSession = AVAudioSession.sharedInstance()
        
        if let number:Int = UserDefaults.standard.object(forKey: "myNumber") as? Int
        {
            numberOfRecords = number
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission
            {
                print ("Accepted")
            }
        }
    }
    
    func getDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    //Function that displays alerts
    func displayAlert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //SETTING UP TABLE VIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRecords
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //sets recording names
        cell.textLabel?.text = "Recording " + String(indexPath.row + 1)
        return cell
    }
    
    //Tap recording to play
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let path = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
        
        do
        {
            recordingPlayer = try AVAudioPlayer(contentsOf: path)
            recordingPlayer.play()
        }
        catch
        {
            
        }
    }
}
