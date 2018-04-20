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
    
    @IBOutlet weak var duration: UILabel!
    
    
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


