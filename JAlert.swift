//
//  JAlert.swift
//  JAlert
//
//  Created by 장효원 on 2022/01/02.
//

import UIKit

public class JAlert: UIView {
    
    public weak var delegate: JAlertDelegate? // delegate
    
    public var titleLabel: UILabel!
    public var messageLabel: UILabel!
    
    public var titleSideMargin: CGFloat = 20.0
    public var messageSideMargin: CGFloat = 20.0
    public var titleTopMargin: CGFloat = 20.0
    public var titleToMessageSpacing: CGFloat = 20.0
    
    // MARK: Closures
    public var onButtonClicked: ((_ buttonIndex: Int) -> Void)?
    public var onCancelClicked: (() -> Void)?
    public var onActionButtonClicked: ((_ buttonIndex: Int) -> (Void))?
    
    public var cornerRadius: CGFloat = 8.0
    
    // MARK: Private Properties
    private var title: String?
    private var message: String?
    private var alertType: AlertType = .default
    private var viewWidth: CGFloat = 0
    private var viewHeight: CGFloat = 0
    
    //Default
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
        frame = CGRect(x: (view.frame.size.width - viewWidth)/2, y: (view.frame.size.height - viewHeight)/2, width: viewWidth, height: viewHeight)
        
        view.addSubview(self)
        view.bringSubview(toFront: self)
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
        layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    private func setupElements() {
        titleLabel = UILabel(frame: .zero)
        messageLabel = UILabel(frame: .zero)
        
        if title != nil {
            titleLabel.text = title
            addSubview(titleLabel)
        }
        if message != nil {
            messageLabel.text = message
            addSubview(messageLabel)
        }
        
        setupElemetsFrame()
    }
    
    private func setupElemetsFrame() {
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
