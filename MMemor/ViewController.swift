import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var durationInputField: UITextField!
    @IBOutlet weak var intervalInputField: UITextField!

    @IBAction func startButtonPressed(_ sender: Any) {
        let durationValue = Float(durationInputField.text ?? "") ?? 0.0
        let intervalValue = Float(intervalInputField.text ?? "") ?? 0.0

        runTimer(for: TimeInterval(intervalValue), duration: TimeInterval(durationValue))
    }
    
    private struct Constants {
        static let secondsMultiplier: Double = 60.0
        static let intervalSound: String = "interval_sound"
        static let timerSound: String = "timer_sound"
        static let mp3File: String = "mp3"
    }
    
    var intervalAudioPlayer: AVAudioPlayer?
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            if let fileURL = Bundle.main.path(forResource: Constants.intervalSound, ofType: Constants.mp3File) {
                intervalAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("no file with specified name exists")
            }
        } catch let error {
            print("can't play audio file \(error)")
        }
        
        do {
            if let fileURL = Bundle.main.path(forResource: Constants.timerSound, ofType: Constants.mp3File) {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("no file with specified name exists")
            }
        } catch let error {
            print("can't play audio file \(error)")
        }
    }
    
    func runTimer(for minutes: TimeInterval, duration: TimeInterval) {
        let seconds = minutes * Constants.secondsMultiplier
        let maxCount = Int(duration/minutes)
        var count = 0
        let intervalTimer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: true) { timer in
            
            if count < maxCount {
                count += 1
                self.intervalAudioPlayer?.play()
            } else {
                print("reached max count")
                self.audioPlayer?.play()
                timer.invalidate()
            }

        }
        intervalTimer.fire()
    }
}
