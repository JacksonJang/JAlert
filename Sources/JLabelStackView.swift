import UIKit

class JLabelStackView: UIStackView {
    init() {
        super.init(frame: CGRect.zero)
        
        commonInit()
    }
    
    func commonInit() {
        isLayoutMarginsRelativeArrangement = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
