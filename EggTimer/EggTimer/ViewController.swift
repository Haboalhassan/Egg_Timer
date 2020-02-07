
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?                                      // For Alarm Audio
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var displayLable: UILabel!
    
    let eggTime = ["Soft" : 10 , "Medium" : 15 , "Hard" : 20]       // Dictionary of eggs and Times
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()                                                                  //For count with seconds
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        
        progressBar.progress = 0.0                                                // Will reset Progress to 0 if pressed any egg or finish
        secondPassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)    // That will loop evry second to count by normal second
        
    }
    
    
    // MARK ->Function for update time every second to check the time finish or not
    
    @objc func updateTimer (){
        if secondPassed < totalTime{
            secondPassed += 1
            progressBar.progress = Float(secondPassed) / Float(totalTime)
            displayLable.text = String(secondPassed)
            
        }else{
            displayLable.text = "DONE !"
            playSound(soundName: "alarm_sound")                              // Alarm will start when egg finish booling
            }
        }
    
    // MARK ->Function for Alarm audio if egg finish will alarm you !
    
    func playSound(soundName : String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }

    }
    
