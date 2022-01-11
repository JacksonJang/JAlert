//
//  JAlert.swift
//  JAlert
//
//  Created by 장효원 on 2022/01/02.
//

import UIKit

public class JAlert: UIView {
    
    // MARK: Public Proerties (You can customize Alert View!)
    public weak var delegate: JAlertDelegate? // delegate
    
    public var appearType: AppearType = .default
    public var disappearType: DisappearType = .default
    
    public var cornerRadius: CGFloat = 8.0
    public var textAlignment: NSTextAlignment = .center
    public var alertViewBackgroundColor: UIColor = .white
    public var actionButtonIndex = 0
    public var animationWithDuration:CGFloat = 0.3
  
    public var isUseBackgroundView = true
    public var isUseSeparator = true
    public var isAnimation = true
    
    public var titleSideMargin: CGFloat = 20.0
    public var titleTopMargin: CGFloat = 20.0
    public var titleToMessageSpacing: CGFloat = 20.0
    public var messageSideMargin: CGFloat = 20.0
    public var messageBottomMargin: CGFloat = 20.0
    
    public var onButtonClicked: ((_ buttonIndex: Int) -> Void)?
    public var onCancelClicked: (() -> Void)?
    public var onActionButtonClicked: ((_ buttonIndex: Int) -> (Void))?
    
    // MARK: Private Properties
    private var alertType: AlertType = .default
    
    private var backgroundView: UIView!
    private var alertView: UIView!
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    
    private var title: String?
    private var message: String?
    private var viewWidth: CGFloat = 0
    private var viewHeight: CGFloat = 0
    
    private var buttonTitle: String?
    private var buttonTitles: [String] = ["OK", "Cancel"]
    private var buttons: [UIButton] = []
    private var buttonHeight: CGFloat = 44.0
    
    private let kDefaultWidth: CGFloat = 270.0
    private let kDefaultHeight: CGFloat = 144.0
    private let kDefaultCornerRadius: CGFloat = 8.0
    
    // MARK: Initialization
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(title: String? = nil, message: String? = nil, alertType: AlertType = .default) {
        super.init(frame: CGRect(x: 0, y: 0, width: kDefaultWidth, height: kDefaultHeight))
        setup(title: title, message: message, alertType: alertType)
    }
    
    private func show(in view: UIView) {
        frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
        backgroundView.frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
        
        addButtonToAlertView()
        setupElemetsFrame()
        
        view.addSubview(self)
        view.bringSubviewToFront(self)
    }
    
}

//Public function
extension JAlert {
    
    //TODO: (comfirm) : ["OK", "Cancel"]가 기본값. 그러므로 setActionButtonName, setCancelButtonName 추가 필요
    //TODO: (default) : ["OK"]가 기본값. setActionButtonName
    public func setButtonName(actionName:String, cancelName:String? = nil) {
        if cancelName != nil {
            buttonTitles = [actionName, cancelName!]
        } else {
            buttonTitles = [actionName]
        }
    }

    public func setMultiButton(titles:[String]) {
        buttonTitles = titles
    }
    
    public func show() {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            show(in: window)
        }
    }
    
}

extension JAlert {
    
    private func setup(title: String? = nil,
                       message: String? = nil,
                       alertType: AlertType) {
        self.title = title
        self.message = message
        self.alertType = alertType
        
        setupDefaultValue()
        setupElements()
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceDidRotate(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    private func setupDefaultValue() {
        clipsToBounds = true
        viewWidth = kDefaultWidth
        viewHeight = kDefaultHeight
        cornerRadius = kDefaultCornerRadius
    }
    
    private func setupElements() {
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        alertView = UIView(frame: .zero)
        titleLabel = UILabel(frame: .zero)
        messageLabel = UILabel(frame: .zero)
        
        addSubview(backgroundView)
        addSubview(alertView)
        
        if title != nil {
            titleLabel.text = title
            titleLabel.textAlignment = textAlignment
            alertView.addSubview(titleLabel)
        }
        
        if message != nil {
            messageLabel.text = message
            messageLabel.textAlignment = textAlignment
            alertView.addSubview(messageLabel)
        }
        
    }
    
    private func addButtonToAlertView() {
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .custom)
            button.setTitle(buttonTitle, for: .normal)
            buttons.append(button)
            alertView.addSubview(button)
        }
    }
    
    private func setupElemetsFrame() {
        self.isHiddenJAlert(status: true)
        
        if title != nil {
            titleLabel.frame = CGRect(x: 0, y: 0, width: viewWidth - titleSideMargin*2, height: 0)
            labelHeightToFit(titleLabel)
        }
        
        if message != nil {
            messageLabel.frame = CGRect(x: 0, y: 0, width: viewWidth - messageSideMargin*2, height: 0)
            labelHeightToFit(messageLabel)
        }
        
        if title != nil {
            titleLabel.center = CGPoint(x: viewWidth/2, y: titleTopMargin + titleLabel.frame.size.height/2)
        }
        
        if message != nil {
            messageLabel.center = CGPoint(x: viewWidth/2, y: titleTopMargin + titleLabel.frame.size.height + titleToMessageSpacing + messageLabel.frame.size.height/2)
        }
        
        var i = 0
        for button in buttons {
            button.tag = i
            i += 1
            button.backgroundColor = .clear
            button.setTitleColor(.black, for: .normal)
            
            if alertType == .default || alertType == .confirm {
                if button.tag == actionButtonIndex {
                    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
                } else {
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                }
            }
            
            button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        }
        
        setupButtonView()
        updateAlertViewFrame()
        setupAnimation()
    }
    
    private func setupButtonView() {
        switch alertType {
        case .default:
            let topPartHeight = titleTopMargin + titleLabel.frame.size.height + titleToMessageSpacing + messageLabel.frame.size.height + messageBottomMargin
            
            viewHeight = topPartHeight + buttonHeight
            
            let button = buttons.first!
            
            button.frame = CGRect(x: 0, y: viewHeight-buttonHeight, width: viewWidth, height: buttonHeight)
            if isUseSeparator {
                let lineView = UIView(frame: CGRect(x: 0, y: button.frame.origin.y, width: viewWidth, height: 0.5))
                lineView.backgroundColor = .black
                alertView.addSubview(lineView)
            }
        case .confirm:
            let topPartHeight = titleTopMargin + titleLabel.frame.size.height + titleToMessageSpacing + messageLabel.frame.size.height + messageBottomMargin
            
            viewHeight = topPartHeight + buttonHeight
            let leftButton = buttons[0]
            let rightButton = buttons[1]
            leftButton.frame = CGRect(x: 0, y: viewHeight-buttonHeight, width: viewWidth/2, height: buttonHeight)
            rightButton.frame = CGRect(x: viewWidth/2, y: viewHeight-buttonHeight, width: viewWidth/2, height: buttonHeight)

            if isUseSeparator {
                let horLine = UIView(frame: CGRect(x: 0, y: leftButton.frame.origin.y, width: viewWidth, height: 0.5))
                horLine.backgroundColor = .black
                self.alertView.addSubview(horLine)

                let verLine = UIView(frame: CGRect(x: viewWidth/2, y: leftButton.frame.origin.y, width: 0.5, height: leftButton.frame.size.height))
                verLine.backgroundColor = .black
                self.alertView.addSubview(verLine)
            }
        case .multi:
            let topPartHeight = titleTopMargin + titleLabel.frame.size.height + titleToMessageSpacing + messageLabel.frame.size.height + messageBottomMargin
            
            viewHeight = topPartHeight + buttonHeight * CGFloat(buttons.count)
            var j = 1
            
            for button in buttons.reversed() {
                button.frame = CGRect(x: 0, y: viewHeight-buttonHeight*CGFloat(j), width: viewWidth, height: buttonHeight)
                j += 1
                if isUseSeparator {
                    let lineView = UIView(frame: CGRect(x: 0, y: button.frame.origin.y, width: viewWidth, height: 0.5))
                    lineView.backgroundColor = .black
                    alertView.addSubview(lineView)
                }
            }
        }
        
    }
    
    private func updateAlertViewFrame() {
        alertView.frame = CGRect(x: (backgroundView.frame.size.width - viewWidth)/2, y: (backgroundView.frame.size.height - viewHeight)/2, width: viewWidth, height: viewHeight)
        alertView.backgroundColor = alertViewBackgroundColor
        alertView.layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    private func setupAnimation(){
        self.isHiddenJAlert(status: false)
        
        //Add animation Type
        if isAnimation {
            showAppearAnimation()
        }
    }
    
    private func showAppearAnimation() {
        switch appearType {
        case .scale:
            self.alertView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            
            UIView.animate(withDuration: animationWithDuration, animations: {
                self.alertView.transform = CGAffineTransform.identity
            })
        case .default:
            self.isHiddenJAlert(status: true)
            
            UIView.animate(withDuration: animationWithDuration, animations: {
                self.isHiddenJAlert(status: false)
            })
        }
    }
    
    private func closeAnimation(completion:@escaping () -> Void) {
        switch disappearType {
        case .scale:
            self.alertView.transform = CGAffineTransform.identity
            
            UIView.animate(withDuration: animationWithDuration, animations: {
                self.alertView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.isHiddenJAlert(status: true)
            }, completion: { _ in
                completion()
            })
        case .default:
            UIView.animate(withDuration: animationWithDuration, animations: {
                self.isHiddenJAlert(status: true)
            }, completion: { _ in
                completion()
            })
        }
    }
    
    private func isHiddenJAlert(status:Bool){
        if status {
            self.backgroundView.alpha = 0
            self.alertView.alpha = 0
        } else {
            if isUseBackgroundView {
                backgroundView.backgroundColor = .black
                backgroundView.alpha = 0.5
            } else {
                backgroundView.alpha = 0
            }
            self.alertView.alpha = 1
        }
    }
    
    private func customAnimationEvent(animations:@escaping () -> Void, completion:(() -> Void)? = nil ){
        UIView.animate(withDuration: animationWithDuration, animations: {
            animations()
        }){ _ in
            if completion != nil {
                completion!()
            }
        }
    }
    
    private func close() {
        if self.isAnimation {
            closeAnimation { self.removeFromSuperview() }
        } else {
            self.removeFromSuperview()
        }
        
        self.isHiddenJAlert(status: true)
    }
    
    @objc private func deviceDidRotate(_ aNotifitation: NSNotification) -> Void {
        show()
    }
    
    @objc private func buttonClicked(_ button: UIButton) {
        close()
        
        let buttonIndex = button.tag
        
        delegate?.alertView?(self, clickedButtonAtIndex: buttonIndex)
        
        onButtonClicked?(buttonIndex)

        if buttonIndex == actionButtonIndex {
            onActionButtonClicked?(buttonIndex)
        } else {
            onCancelClicked?()
        }
    }
}


@objc public protocol JAlertDelegate : NSObjectProtocol {
    @objc optional func alertView(_ alertView: JAlert, clickedButtonAtIndex buttonIndex: Int)
}

//Utils Function
extension JAlert {
    private func labelHeightToFit(_ label: UILabel) {
        let maxWidth = label.frame.size.width
        let maxHeight = CGFloat.greatestFiniteMagnitude
        let rect = label.attributedText?.boundingRect(
            with: CGSize(width: maxWidth, height: maxHeight),
            options: .usesLineFragmentOrigin,
            context: nil)
        
        label.frame.size.height = rect!.size.height
    }
}
