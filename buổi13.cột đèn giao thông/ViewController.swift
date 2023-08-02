

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var trafficView: UIView!
    
    @IBOutlet weak var yellowLightView: UIView!
    @IBOutlet weak var greenLightView: UIView!
    @IBOutlet weak var redLightView: UIView!
    
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var labelView: UILabel!
    
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var yellowTextField: UITextField!
    @IBOutlet weak var redTextField: UITextField!
    
    let tapButton: TapButton = {
        let button = TapButton()
        return button
    }()
    
    var redTimer: Timer!
    var yellowTimer: Timer!
    var greenTimer: Timer!
    var r: Int = 0
    var y: Int = 0
    var g: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        trafficView.frame = CGRect(
            x: 0,
            y: 0,
            width: 150,
            height: 400)
        trafficView.center.x = view.center.x
        trafficView.center.y = view.center.y - 100
        trafficView.backgroundColor = .black
        trafficView.layer.cornerRadius = 20
        trafficView.layer.borderWidth = 15
        trafficView.layer.borderColor = UIColor.white.cgColor
        
        redLightView.backgroundColor = .gray
        redLightView.layer.borderWidth = 10
        redLightView.layer.borderColor = UIColor.white.cgColor
        redLightView.frame = CGRect(
            x: 25,
            y: 25,
            width: 100,
            height: 100)
        
        yellowLightView.backgroundColor = .gray
        yellowLightView.layer.borderWidth = 10
        yellowLightView.layer.borderColor = UIColor.white.cgColor
        yellowLightView.frame = CGRect(
            x: redLightView.frame.minX,
            y: redLightView.frame.maxY + 25,
            width: 100,
            height: 100)
        
        greenLightView.backgroundColor = .gray
        greenLightView.layer.borderWidth = 10
        greenLightView.layer.borderColor = UIColor.white.cgColor
        greenLightView.frame = CGRect(
            x: redLightView.frame.minX,
            y: yellowLightView.frame.maxY + 25,
            width: 100,
            height: 100)
        
        yellowButton.frame = CGRect(
            x: view.center.x - 50,
            y: view.frame.maxY - 100,
            width: 100,
            height: 50)
        yellowButton.setTitle("YELLOW", for: .normal)
        yellowButton.setTitleColor(.black, for: .normal)
        yellowButton.backgroundColor = .yellow
        yellowButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        yellowButton.layer.cornerRadius = 10
        
        redButton.frame = CGRect(
            x: yellowButton.frame.minX - 130,
            y: yellowButton.frame.minY,
            width: 100,
            height: 50)
        redButton.setTitle("RED", for: .normal)
        redButton.setTitleColor(.black, for: .normal)
        redButton.backgroundColor = .red
        redButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        redButton.layer.cornerRadius = 10
        
        greenButton.frame = CGRect(
            x: yellowButton.frame.maxX + 30,
            y: yellowButton.frame.minY,
            width: 100,
            height: 50)
        greenButton.setTitle("GREEN", for: .normal)
        greenButton.setTitleColor(.black, for: .normal)
        greenButton.backgroundColor = .green
        greenButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        greenButton.layer.cornerRadius = 10
        
        redTextField.font = UIFont.systemFont(ofSize: 10)
        redTextField.layer.cornerRadius = 10
        redTextField.frame = CGRect(
            x: redButton.center.x - 50,
            y: redButton.frame.minY - 35,
            width: 100,
            height: 30)
        
        yellowTextField.font = UIFont.systemFont(ofSize: 10)
        yellowTextField.layer.cornerRadius = 10
        yellowTextField.frame = CGRect(
            x: yellowButton.center.x - 50,
            y: yellowButton.frame.minY - 35,
            width: 100,
            height: 30)
        
        greenTextField.font = UIFont.systemFont(ofSize: 10)
        greenTextField.layer.cornerRadius = 10
        greenTextField.frame = CGRect(
            x: greenButton.center.x - 50,
            y: greenButton.frame.minY - 35,
            width: 100,
            height: 30)
        
        labelView.text = "0"
        labelView.frame = CGRect(
            x: view.center.x - 50,
            y: trafficView.frame.maxY + 20,
            width: 100,
            height: 50)
        labelView.font = UIFont.boldSystemFont(ofSize: 30)
        labelView.layer.borderWidth = 5
        labelView.layer.borderColor = UIColor.gray.cgColor
        labelView.backgroundColor = .white
        
        self.view.addSubview(tapButton)
        tapButton.frame = CGRect(
            x: labelView.center.x - 30,
            y: labelView.frame.maxY + 70,
            width: 60,
            height: 30)
        tapButton.addTarget(self, action: #selector(runTime), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        yellowLightView.layer.cornerRadius = yellowLightView.bounds.height/2
        redLightView.layer.cornerRadius = redLightView.bounds.height/2
        greenLightView.layer.cornerRadius = greenLightView.bounds.height/2
    }
    
    @objc func runTime(){
        let r = Int(redTextField.text!)
        let y = Int(yellowTextField.text!)
        let g = Int(greenTextField.text!)
        
        if r == nil || y == nil || g == nil {
            print("Hãy nhập số giây cho cả 3 đèn")
            return
        } else if r! <= 0 || y! <= 0 || g! <= 0{
            print("Số nhập vào phải lớn hơn 0")
            return
        }
        
        self.g = g!
        self.r = r!
        self.y = y!
        
        labelView.text = "\(self.g)"
        greenTap()
        greenTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runGreenLight), userInfo: nil, repeats: true)
    }
    
    @objc func runGreenLight(){
        g -= 1
        greenTap()
        labelView.text = "\(g)"
        if g < 0 {
            greenTimer.invalidate()
            g = Int(greenTextField.text!)!
            
            labelView.text = "\(y)"
            yellowTap()
            yellowTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runYellowLight), userInfo: nil, repeats: true)
        }
    }
    
    @objc func runYellowLight(){
        y -= 1
        labelView.text = "\(y)"
        yellowTap()
        if y < 0 {
            yellowTimer.invalidate()
            y = Int(yellowTextField.text!)!
            
            labelView.text = "\(r)"
            redTap()
            redTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runRedLight), userInfo: nil, repeats: true)
        }
    }
    
    @objc func runRedLight(){
        r -= 1
        labelView.text = "\(r)"
        redTap()
        if r < 0{
            redTimer.invalidate()
            r = Int(redTextField.text!)!
            
            labelView.text = "\(g)"
            greenTap()
            greenTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runGreenLight), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func redTap() {
        redLightView.backgroundColor = .red
        yellowLightView.backgroundColor = .gray
        greenLightView.backgroundColor = .gray
        labelView.textColor = .red
        labelView.backgroundColor = .black
    }
    
    @IBAction func yellowTap() {
        yellowLightView.backgroundColor = .yellow
        greenLightView.backgroundColor = .gray
        redLightView.backgroundColor = .gray
        labelView.textColor = .yellow
        labelView.backgroundColor = .black
    }
    
    @IBAction func greenTap() {
        yellowLightView.backgroundColor = .gray
        greenLightView.backgroundColor = .green
        redLightView.backgroundColor = .gray
        labelView.textColor = .green
        labelView.backgroundColor = .black
    }
}

