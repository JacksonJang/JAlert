//
//  JAlert.swift
//  JAlert
//
//  Created by 장효원 on 2022/01/02.
//

import UIKit

public class JAlert: UIView {
    
    public weak var delegate: JAlertDelegate? // delegate
    
    // MARK: Can change Property
    public var cornerRadius: CGFloat = 8.0
    public var textAlignment: NSTextAlignment = .center
    public var alertViewBackgroundColor: UIColor = .white
    public var isUseBackgroundView = true
    public var isHideSeparator = false // to hide the separater color
    public var cancelButtonIndex = 0
    
    // MARK: Margin
    public var titleSideMargin: CGFloat = 20.0
    public var titleTopMargin: CGFloat = 20.0
    public var titleToMessageSpacing: CGFloat = 20.0
    public var messageSideMargin: CGFloat = 20.0
    public var messageBottomMargin: CGFloat = 20.0
    
    // MARK: Closures
    public var onButtonClicked: ((_ buttonIndex: Int) -> Void)?
    public var onCancelClicked: (() -> Void)?
    public var onActionButtonClicked: ((_ buttonIndex: Int) -> (Void))?
    
    // MARK: Elements
    private var backgroundView: UIView!
    private var alertView: UIView!
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    
    // MARK: Private Properties
    private var alertType: AlertType = .default
    private var title: String?
    private var message: String?
    private var viewWidth: CGFloat = 0
    private var viewHeight: CGFloat = 0
    
    // MARK: Button
    private var buttonTitle: String?
    private var buttonTitles: [String] = ["확인"]
    private var buttons: [UIButton] = []
    private var buttonHeight: CGFloat = 44.0
    
    // MARK: UI Default
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
    
    public func show() {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            show(in: window)
        }
    }
    
    public func show(in view: UIView) {
        frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
        
        view.addSubview(self)
        view.bringSubviewToFront(self)
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
        
        if isUseBackgroundView {
            addSubview(backgroundView)
        }
        
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
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .custom)
            button.setTitle(buttonTitle, for: .normal)
            buttons.append(button)
            alertView.addSubview(button)
        }
        
        setupElemetsFrame()
    }
    
    private func setupElemetsFrame() {
        if isUseBackgroundView {
            backgroundView.backgroundColor = .black
            backgroundView.alpha = 0.5
        }
        
        alertView.frame = CGRect(x: (backgroundView.frame.size.width - viewWidth)/2, y: (backgroundView.frame.size.height - viewHeight)/2, width: viewWidth, height: viewHeight)
        alertView.backgroundColor = alertViewBackgroundColor
        alertView.layer.cornerRadius = CGFloat(cornerRadius)
        
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
            if button.tag == cancelButtonIndex {
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            } else {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            }
            
            button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        }
        
        createButtonView()
    }
    
    func createButtonView() {
        let topPartHeight = titleTopMargin + titleLabel.frame.size.height + titleToMessageSpacing + messageLabel.frame.size.height + messageBottomMargin
        
        viewHeight = topPartHeight + buttonHeight * CGFloat(buttons.count)
        var j = 1
        
        for button in buttons.reversed() {
            button.frame = CGRect(x: 0, y: viewHeight-buttonHeight*CGFloat(j), width: viewWidth, height: buttonHeight)
            j += 1
            if !isHideSeparator {
                let lineView = UIView(frame: CGRect(x: 0, y: button.frame.origin.y, width: viewWidth, height: 0.5))
                lineView.backgroundColor = .black
                alertView.addSubview(lineView)
            }
        }
    }
    
    @objc private func buttonClicked(_ button: UIButton) {
        let buttonIndex = button.tag
        
        delegate?.alertView?(self, clickedButtonAtIndex: buttonIndex)

        onButtonClicked?(buttonIndex)

        if buttonIndex == cancelButtonIndex {
            onCancelClicked?()
        } else {
            onActionButtonClicked?(buttonIndex)
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
        let maxHeight : CGFloat = 10000
        let rect = label.attributedText?.boundingRect(
            with: CGSize(width: maxWidth, height: maxHeight),
            options: .usesLineFragmentOrigin,
            context: nil)
        
        var frame = label.frame
        frame.size.height = rect!.size.height
        label.frame = frame
    }
}
