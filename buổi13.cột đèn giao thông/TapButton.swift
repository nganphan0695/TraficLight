

import UIKit

class TapButton: UIButton{

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitle("START", for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
