import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            if let fileURL = Bundle.main.path(forResource: "sound", ofType: "mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("no file with specified name exists")
            }
        } catch let error {
            print("can't play audio file \(error)")
        }

        runTimer(for: 3.0)
    }
    
    func runTimer(for minutes: TimeInterval, duration: TimeInterval = 0.0) {
        let secondsMultiplier = 60.0
        let seconds = minutes * secondsMultiplier
        let timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: true) { timer in
            self.audioPlayer?.play()
            print("play")
        }
        timer.fire()
    }
}

