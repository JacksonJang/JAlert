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
    
    public var alertBackgroundColor: UIColor = .white
    public var cornerRadius: CGFloat = 8.0
    public var textAlignment: NSTextAlignment = .center
    public var animationWithDuration:CGFloat = 0.3
    
    public var dateFormat = "yyyy-MM-dd HH:mm:ss" // Use for ".date" type.(default: "yyyy-MM-dd HH:mm:ss")
    public var language:Language = .en_US // Use for ".date" type.(default: .en_US)
    public var urlString:String = "" //Use for ".image" type.
    
    //Color
    public var titleColor:UIColor = UIColor.black
    public var messageColor:UIColor = UIColor.black
    public var actionButtonColor:UIColor = UIColor.black
    public var cancelButtonColor:UIColor = UIColor.black
    public var submitColor:UIColor = UIColor.black
    
    //Font
    public var titleFont:UIFont = UIFont.systemFont(ofSize: 17)
    public var messageFont:UIFont = UIFont.systemFont(ofSize: 17)
    public var actionButtonFont:UIFont = UIFont.systemFont(ofSize: 17, weight: .bold)
    public var cancelButtonFont:UIFont = UIFont.systemFont(ofSize: 17)
    public var submitFont:UIFont = UIFont.systemFont(ofSize: 17)
  
    public var isUseBackgroundView = true
    public var isUseSeparator = true
    public var isAnimation = true
    
    public var titleSideMargin: CGFloat = 20.0
    public var titleTopMargin: CGFloat = 20.0
    public var titleBottomMargin: CGFloat = 20.0
    public var messageSideMargin: CGFloat = 20.0
    public var messageBottomMargin: CGFloat = 20.0
    public var submitSideMargin: CGFloat = 20.0
    public var submitBottomMargin: CGFloat = 20.0
    public var datePickerViewSideMargin: CGFloat = 20.0
    public var datePickerViewBottomMargin: CGFloat = 20.0
    public var imageViewSideMargin: CGFloat = 20.0
    public var imageViewBottomMargin: CGFloat = 20.0
    
    public var submitViewHeight:CGFloat = 150
    public var datePickerViewHeight:CGFloat = 250
    public var imageHeight:CGFloat = 500
    
    // MARK: Private Properties
    private var alertType: AlertType = .default
    
    private var backgroundView: UIView!
    private var alertView: UIView!
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    private var submitView: UITextView!
    private var datePickerView: UIDatePicker!
    private var imageView:UIImageView!
    
    private var title: String?
    private var message: String?
    private var viewWidth: CGFloat = 0
    private var viewHeight: CGFloat = 0
    
    private var buttonTitle: String?
    private var buttonTitles: [String] = ["OK", "Cancel"]
    private var buttons: [UIButton] = []
    private var buttonHeight: CGFloat = 44.0
    private var actionButtonIndex = 0
    
    private var isUseButton:Bool = false
    
    private var onActionClicked: (() -> Void)?
    private var onCancelClicked: (() -> Void)?
    
    private let kDefaultWidth: CGFloat = 300.0
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
        setupDefaultValue()
        setupElements()
        
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
    
    public func setButton(actionName:String, cancelName:String? = nil, onActionClicked: (() -> Void)? = nil, onCancelClicked: (() -> Void)? = nil) {
        if cancelName != nil {
            isUseButton = true
            buttonTitles = [actionName, cancelName!]
        } else {
            isUseButton = true
            buttonTitles = [actionName]
        }
        
        self.onActionClicked = onActionClicked
        self.onCancelClicked = onCancelClicked
    }
    
    public func getSubmitText() -> String {
        if submitView != nil {
            return submitView.text!
        } else {
            return ""
        }
    }
    
    public func getDate() -> String {
        if datePickerView != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat

            let dateString:String = dateFormatter.string(from: datePickerView.date)
            
            return dateString
        } else {
            return ""
        }
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceDidRotate(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    private func setupDefaultValue() {
        clipsToBounds = true
        viewWidth = kDefaultWidth
        viewHeight = kDefaultHeight
        cornerRadius = kDefaultCornerRadius
    }
    
    private func setupElements() {
        initializeDefaultView()
        
        if title != nil {
            titleLabel.text = title
            titleLabel.textAlignment = textAlignment
            titleLabel.textColor = titleColor
            titleLabel.font = titleFont
            alertView.addSubview(titleLabel)
        } else {
            updateMarginToZero(type: .title)
        }
        
        if message != nil {
            messageLabel.text = message
            messageLabel.textAlignment = textAlignment
            messageLabel.textColor = messageColor
            messageLabel.font = messageFont
            alertView.addSubview(messageLabel)
        } else {
            updateMarginToZero(type: .message)
        }
        
        if alertType == .submit {
            submitView.layer.borderColor = UIColor.black.cgColor
            submitView.layer.borderWidth = 0.5
            submitView.textColor = submitColor
            submitView.font = submitFont
            alertView.addSubview(submitView)
        } else {
            updateMarginToZero(type: .submit)
        }
        
        if alertType == .date {
            datePickerView.datePickerMode = .dateAndTime
            if #available(iOS 13.4, *) {
                datePickerView.preferredDatePickerStyle = .wheels
            }
            datePickerView.locale = Locale(identifier: language.rawValue)
            alertView.addSubview(datePickerView)
        } else {
            updateMarginToZero(type: .date)
        }
        
        if alertType == .image {
            alertView.addSubview(imageView)
        } else {
            updateMarginToZero(type: .image)
        }
    }
    
    private func initializeDefaultView() {
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        alertView = UIView(frame: .zero)
        titleLabel = UILabel(frame: .zero)
        messageLabel = UILabel(frame: .zero)
        submitView = UITextView(frame: .zero)
        datePickerView = UIDatePicker(frame: .zero)
        imageView = createImageView(urlString: encodingUrlString())
        
        addSubview(backgroundView)
        addSubview(alertView)
    }
    
    private func createImageView(urlString:String) -> UIImageView{
        guard let url = URL(string: urlString) else { return UIImageView(frame: CGRect.zero) }
        
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)!
            imageHeight = viewWidth * image.size.height / image.size.width
            imageView = UIImageView(image: image)
        } catch {
            print("createImageView error")
        }
        
        if urlString == "" {
            imageView = UIImageView(frame: CGRect.zero)
        }
        
        return imageView
    }
    
    private func addButtonToAlertView() {
        for buttonTitle in buttonTitles {
            createButton(name: buttonTitle)
        }
        
        checkButtonCountAndAppend()
        setButtonProperties()
    }
    
    private func createButton(name:String) {
        let button = UIButton(type: .custom)
        button.setTitle(name, for: .normal)
        buttons.append(button)
        alertView.addSubview(button)
    }
    
    private func checkButtonCountAndAppend() {
        if alertType != .default {
            if !isUseButton {
                if buttons.count == 0 {
                    createButton(name: "Cancel")
                } else if buttons.count == 1 {
                    createButton(name: "OK")
                    createButton(name: "Cancel")
                }
            }
        }
    }
    
    private func setButtonProperties() {
        var i = 0
        for button in buttons {
            button.tag = i
            
            setButtonCustomUI(button: button)
            
            button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
            
            i += 1
        }
    }
    
    private func setButtonCustomUI(button:UIButton) {
        button.backgroundColor = .clear
        
        if button.tag == actionButtonIndex {
            button.setTitleColor(actionButtonColor, for: .normal)
            button.titleLabel?.font = actionButtonFont
        } else {
            button.setTitleColor(cancelButtonColor, for: .normal)
            button.titleLabel?.font = cancelButtonFont
        }
    }
    
    private func setupElemetsFrame() {
        self.isHiddenJAlert(status: true)
        
        if title != nil {
            titleLabel.frame = CGRect(x: 0, y: 0, width: viewWidth - titleSideMargin*2, height: 0)
            labelHeightToFit(titleLabel)
            titleLabel.center = CGPoint(x: viewWidth/2, y: titleTopMargin + titleLabel.frame.size.height/2)
        }
        
        if message != nil {
            messageLabel.frame = CGRect(x: 0, y: 0, width: viewWidth - messageSideMargin*2, height: 0)
            labelHeightToFit(messageLabel)
            messageLabel.center = CGPoint(x: viewWidth/2, y: titleTopMargin + titleLabel.frame.size.height + titleBottomMargin + messageLabel.frame.size.height/2)
        }
        
        if alertType == .submit {
            submitView.frame = CGRect(x: 0, y: 0, width: viewWidth - submitSideMargin*2 - 10, height: submitViewHeight)
            submitView.center = CGPoint(x: viewWidth/2, y: titleTopMargin + titleLabel.frame.size.height + titleBottomMargin + messageLabel.frame.size.height + messageBottomMargin + submitView.frame.size.height/2)
        }
        
        if alertType == .date {
            datePickerView.frame = CGRect(x: 0, y: 0, width: viewWidth - datePickerViewSideMargin*2 - 10, height: datePickerViewHeight)
            datePickerView.center = CGPoint(x: viewWidth/2, y: titleTopMargin + titleLabel.frame.size.height + titleBottomMargin + messageLabel.frame.size.height + messageBottomMargin + datePickerView.frame.size.height/2)
        }

        if alertType == .image {
            imageView.frame = CGRect(x: 0, y: 0, width: viewWidth - imageViewSideMargin*2 - 10, height: imageHeight)
            
            imageView.center = CGPoint(x: viewWidth/2, y: titleTopMargin + titleLabel.frame.size.height + titleBottomMargin + messageLabel.frame.size.height + messageBottomMargin + imageView.frame.size.height/2)
        }
        
        setupButtonView()
        updateAlertViewFrame()
        setupAnimation()
    }
    
    private func setupButtonView() {
        switch alertType {
        case .default:
            let topPartHeight = titleTopMargin + titleLabel.frame.size.height + titleBottomMargin + messageLabel.frame.size.height + messageBottomMargin
            
            viewHeight = topPartHeight + buttonHeight
            
            let button = buttons.first!
            
            button.frame = CGRect(x: 0, y: viewHeight-buttonHeight, width: viewWidth, height: buttonHeight)
            if isUseSeparator {
                let lineView = UIView(frame: CGRect(x: 0, y: button.frame.origin.y, width: viewWidth, height: 0.5))
                lineView.backgroundColor = .black
                alertView.addSubview(lineView)
            }
        case .confirm:
            let topPartHeight = titleTopMargin + titleLabel.frame.size.height + titleBottomMargin + messageLabel.frame.size.height + messageBottomMargin
            
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
        case .submit:
            let topPartHeight = titleTopMargin + titleLabel.frame.size.height + titleBottomMargin + messageLabel.frame.size.height + messageBottomMargin + submitView.frame.size.height + submitBottomMargin
            
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
        case .date:
            let topPartHeight = titleTopMargin + titleLabel.frame.size.height + titleBottomMargin + messageLabel.frame.size.height + messageBottomMargin + datePickerView.frame.size.height + datePickerViewBottomMargin
            
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
        case .image:
            let topPartHeight = titleTopMargin + titleLabel.frame.size.height + titleBottomMargin + messageLabel.frame.size.height + messageBottomMargin + imageView.frame.size.height + imageViewBottomMargin
            
            viewHeight = topPartHeight + buttonHeight
            
            if buttons.count >= 2 {
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
            } else {
                let button = buttons.first!
                
                button.frame = CGRect(x: 0, y: viewHeight-buttonHeight, width: viewWidth, height: buttonHeight)
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
        alertView.backgroundColor = alertBackgroundColor
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
    
    private func encodingUrlString() -> String {
        let urlString = self.urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if urlString == nil {
            return self.urlString
        } else {
            return urlString!
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
}

// @objc
extension JAlert {
    @objc private func deviceDidRotate(_ aNotifitation: NSNotification) -> Void {
        show()
    }
    
    @objc private func buttonClicked(_ button: UIButton) {
        close()
        
        let buttonIndex = button.tag
        
        delegate?.alertView?(self, clickedButtonAtIndex: buttonIndex)

        if buttonIndex == actionButtonIndex {
            onActionClicked?()
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
    
    private func updateMarginToZero(type: ElementType) {
        switch type {
        case .title:
            titleTopMargin = 0
            titleSideMargin = 0
            titleBottomMargin = 0
            break;
        case .message:
            messageBottomMargin = 0
            messageSideMargin = 0
            break;
        case .submit:
            submitSideMargin = 0
            submitBottomMargin = 0
            break;
        case .date:
            datePickerViewSideMargin = 0
            datePickerViewBottomMargin = 0
            break;
        case .image:
            imageViewSideMargin = 0
            imageViewBottomMargin = 0
            break;
        default:
            break;
        }
    }
}
