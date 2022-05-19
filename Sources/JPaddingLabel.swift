import UIKit

class JPaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

    init(top:CGFloat = 0.0, left:CGFloat = 0.0, bottom:CGFloat = 0.0, right:CGFloat = 0.0) {
        super.init(frame: CGRect.zero)
        self.padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        
        commonInit()
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        commonInit()
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
}
