//
//  SecondViewController.swift
//  AppFinal
//
//  Created by Victor Bak on 2018-04-13.
//  Copyright © 2018 Victor Bak. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    var step = 1
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedSwitch: UISwitch!
    
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var remaining: UILabel!
    
    @IBAction func toggle(_ sender: Any) {
        switchIsChanged(speedSwitch: speedSwitch)
    }
    @IBAction func play(_ sender: Any) {
        audioPlayer.enableRate = true;
        if (!audioPlayer.isPlaying) {
            audioPlayer.play()
        }

    }
    @IBAction func pause(_ sender: Any) {
        if (audioPlayer.isPlaying) {
            audioPlayer.pause()
        }
    }
    
    @IBAction func prev(_ sender: Any) {
        if (thisSong != 0)
        {
            playThis(thisOne: songs[thisSong - 1])
            thisSong -= 1
        }
        else {
            
        }

    }
    @IBAction func next(_ sender: Any) {
        if(thisSong < songs.count-1){
            playThis(thisOne: songs[thisSong+1])
        }
        else {
            
        }

    }
    
    func playThis(thisOne:String)
    {
        do {
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            thisSong+=1
            audioPlayer.play()
        }
        catch {
            print("ERROR")
        }
    }
    
    @objc func switchIsChanged(speedSwitch: UISwitch) {
        
        if speedSwitch.isOn {
            switch step {
            case 1:
                audioPlayer.stop()
                speedLabel.text = "1.0x speed"
                audioPlayer.enableRate = true
                audioPlayer.rate = 1.0
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                step += 1
            case 2:
                audioPlayer.enableRate = true
                speedLabel.text = "2.0x speed"
                audioPlayer.prepareToPlay()
                audioPlayer.rate = 2.0
                audioPlayer.play()
                step += 1
            case 3:
                speedLabel.text = "0.5x speed"
                audioPlayer.rate = 0.5
                step = 1
            default:
                speedLabel.text = "Default"
            }
        }
    }
    @objc func update(){
        var minutes = Int(audioPlayer.currentTime / 60);
        var seconds = Int(audioPlayer.currentTime.truncatingRemainder(dividingBy: 60));
        duration.text = String(format:"%d:%02d",minutes,seconds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _ = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

