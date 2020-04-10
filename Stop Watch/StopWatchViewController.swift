// Comped from David Tran by Mohd Yasir for Practice purpose
import UIKit

class StopWatchViewController: UIViewController
{
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var timer = Timer()
    var isTimerRunning = false
    var counter = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        
        timerLabel.layer.cornerRadius = 20.0
        timerLabel.layer.masksToBounds = true
        
        resetButton.layer.cornerRadius = 4.0
        resetButton.layer.masksToBounds = true
        resetButton.isEnabled = false
        resetButton.alpha = 0.5
        
//        startButton.layer.cornerRadius = startButton.bounds.width / 2.0
//        startButton.layer.masksToBounds = true
        
//        pauseButton.layer.cornerRadius = pauseButton.bounds.width / 2.0
//        pauseButton.layer.masksToBounds = true
        pauseButton.isEnabled = false
//        pauseButton.alpha = 0.5
    }
    
    @IBAction func resetDidTap(_ sender: Any)
    {
        timer.invalidate()
        isTimerRunning = false
        counter = 0.0
        
        timerLabel.text = "0:00:00.0"
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        
        resetButton.alpha = 0.5
        startButton.alpha = 1.0
        pauseButton.alpha = 0.5
    }
    
    @IBAction func pauseDidTap(_ sender: Any)
    {
        resetButton.isEnabled = true
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        resetButton.alpha = 1.0
        startButton.alpha = 1.0
        pauseButton.alpha = 0.5
        
        isTimerRunning = false
        timer.invalidate()
    }
    
    @IBAction func startDidTap(_ sender: Any)
    {
        if !isTimerRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
            isTimerRunning = true
            
            resetButton.isEnabled = true
            pauseButton.isEnabled = true
            startButton.isEnabled = false
            
            resetButton.alpha = 1.0
            startButton.alpha = 0.5
            pauseButton.alpha = 1.0
        }
    }
    
    // MARK: - Helper methods
    
    @objc func runTimer() {
        counter += 0.1
        // HH:MM:SS:_
        let flooredCounter = Int(floor(counter))
        let hour = flooredCounter / 3600
        
        let minute = (flooredCounter % 3600) / 60
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        
        let second = (flooredCounter % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }

        let decisecond = String(format: "%.1f", counter).components(separatedBy: ".").last!
        
        timerLabel.text = "\(hour):\(minuteString):\(secondString).\(decisecond)"
    }
}
