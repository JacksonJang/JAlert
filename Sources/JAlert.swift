import UIKit

public let JAlert = JAlertManager.shared

public class JAlertManager: NSObject {
    public static let shared = JAlertManager()
    
    public weak var delegate: JAlertDelegate? // delegate
    
    //MARK: Alert Default Properties
    private var title:String = ""
    private var message:String = ""
    private var buttonTitles:[String] = ["OK"]
    private var completion:((Int) -> Void)? = nil
    private var config:JConfig = JConfig()
    
    //MARK: Parent View
    private var alertView:BaseUIView = BaseUIView()
    private var dimView:BaseUIView = BaseUIView()
    
    //MARK: - StackView
    private lazy var titleLabelStackView:JLabelStackView = JLabelStackView()
    private lazy var messageLabelStackView:JLabelStackView = JLabelStackView()
    
    private lazy var contentStackView:UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.clipsToBounds = true
        sv.layer.masksToBounds = true
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.layer.cornerRadius = config.contentCornerRadius
        sv.backgroundColor = config.backgroundColor
        return sv
    }()
    
    private lazy var buttonStackView:UIStackView = {
        let sv = UIStackView()
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        
        return sv
    }()
    
    //MARK: - Label
    private lazy var titleLabel:JPaddingLabel = JPaddingLabel()
    private lazy var messageLabel:JPaddingLabel = JPaddingLabel()
    private var firstButtonLabel:JPaddingLabel = JPaddingLabel()
    private var secondButtonLabel:JPaddingLabel = JPaddingLabel()
    
    //MARK: - Border
    private lazy var boundaryBorderView:BaseUIView = BaseUIView()
    private lazy var cotentBottomBorderView:BaseUIView = BaseUIView()
    private lazy var secondBorderView:BaseUIView = BaseUIView()
    
    //MARK: - Button
    private var firstButtonView:BaseUIView = BaseUIView()
    private var secondButtonView:BaseUIView = BaseUIView()
    
    //MARK: - init
    public override init() {
        super.init()
        setupUI()
    }
    
    private func setupUI() {
        createJAlert()
    }
}

//MARK: - Public Method
extension JAlertManager {
    public func configuration(config:JConfig) {
        self.config = config
    }
    
    public func show(title:String = "",
                     message:String = "",
                     buttonTitles:[String] = ["OK"],
                     completion:((Int) -> Void)? = nil) {
        self.title = title
        self.message = message
        
        titleLabel.text = self.title
        messageLabel.text = self.message
        
        self.buttonTitles = buttonTitles
        self.completion = completion
        
        updateJConfigProperties()
        updateButtonConfiguration()
        
        showAlertView()
    }
    
    private func showAlertView() {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) {
            window.addSubview(alertView)
               
            NSLayoutConstraint.activate([
                alertView.topAnchor.constraint(equalTo: window.topAnchor),
                alertView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                alertView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                alertView.bottomAnchor.constraint(equalTo: window.bottomAnchor)
            ])
            
            alertView.layoutIfNeeded()
        }
    }
}

extension JAlertManager {
    private func updateJConfigProperties() {
        if title != "" {
            titleLabelStackView.layoutMargins = UIEdgeInsets(top: config.titleTopMargin, left: config.titleLeftMargin, bottom: 0, right: config.titleRightMargin)
        } else {
            titleLabelStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        if #available(iOS 11.0, *) {
            contentStackView.setCustomSpacing(config.betweenTitleAndMessageMargin, after: titleLabelStackView)
        }
        
        if message != "" {
            messageLabelStackView.layoutMargins = UIEdgeInsets(top: 0, left: config.messageLeftMargin, bottom: config.messageBottomMargin, right: config.messageRightMargin)
        } else {
            messageLabelStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        //font
        titleLabel.font = config.titleFont
        messageLabel.font = config.messageFont
        
        var fontIndex = 0
        for font in config.buttonsFont {
            if fontIndex == 0 {
                firstButtonLabel.font = font
            } else if fontIndex == 1 {
                secondButtonLabel.font = font
            }
            fontIndex += 1
        }
        
        //cornerRadius
        contentStackView.layer.cornerRadius = config.contentCornerRadius
        
        //border
        contentStackView.layer.borderWidth = config.contentBorderWidth
        contentStackView.layer.borderColor = config.contentBorderColor.cgColor
        
        //background
        contentStackView.backgroundColor = config.backgroundColor
        cotentBottomBorderView.backgroundColor = config.borderColor
        secondBorderView.backgroundColor = config.borderColor
    }
    
    private func updateButtonConfiguration() {
        for index in 0..<buttonTitles.count {
            if index == 0 {
                firstButtonLabel.text = buttonTitles[index]
                secondButtonView.isHidden = true
            } else if index == 1 {
                secondButtonLabel.text = buttonTitles[index]
                secondButtonView.isHidden = false
            }
        }
    }
}

extension JAlertManager {
    private func createJAlert(){
        setupDimView()
        setupContentStackView()
        setupBetweenCotentAndButtonBorderView()
        setupButtonStackView()
    }
    
    private func setupDimView() {
        dimView.backgroundColor = UIColor.black.withAlphaComponent(config.backgroundWithAlphaComponent)
        
        alertView.addSubview(dimView)
        
        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: alertView.topAnchor),
            dimView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor)
        ])
    }
    
    private func setupContentStackView() {
        setupAlertContentView()
        addTitleAndMessageToContentStackView()
    }
    
    private func addTitleAndMessageToContentStackView() {
        titleLabelStackView.addArrangedSubview(titleLabel)
        messageLabelStackView.addArrangedSubview(messageLabel)
        
        contentStackView.addArrangedSubview(titleLabelStackView)
        contentStackView.addArrangedSubview(messageLabelStackView)
    }
    
    private func setupAlertContentView() {
        alertView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupBetweenCotentAndButtonBorderView() {
        contentStackView.addArrangedSubview(cotentBottomBorderView)
        
        NSLayoutConstraint.activate([
            cotentBottomBorderView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            cotentBottomBorderView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            cotentBottomBorderView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupButtonStackView() {
        buttonStackView.addArrangedSubview(firstButtonView)
        buttonStackView.addArrangedSubview(secondButtonView)
        contentStackView.addArrangedSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        setupFirstButtonView()
        setupSecondButtonView()
    }
    
    private func setupFirstButtonView() {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onTouchFirstButtonView(sender:)), for: .touchUpInside)
        
        [
            firstButtonLabel,
            button
        ].forEach{
            firstButtonView.addSubview($0)
        }
        
        if let superView = button.superview {
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: superView.topAnchor),
                button.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
                button.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
                firstButtonLabel.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
                firstButtonLabel.centerYAnchor.constraint(equalTo: superView.centerYAnchor),
            ])
        }
    }
    
    private func setupSecondButtonView() {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onTouchSecondButtonView(sender:)), for: .touchUpInside)
        
        [
            secondButtonLabel,
            button
        ].forEach{
            secondButtonView.addSubview($0)
        }
        
        if let superView = button.superview {
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: superView.topAnchor),
                button.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
                button.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
                secondButtonLabel.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
                secondButtonLabel.centerYAnchor.constraint(equalTo: superView.centerYAnchor),
            ])
        }
        
        setupSecondButtonLeftBorderView()
    }
    
    private func setupSecondButtonLeftBorderView() {
        secondButtonView.addSubview(secondBorderView)
        
        NSLayoutConstraint.activate([
            secondBorderView.topAnchor.constraint(equalTo: secondButtonView.topAnchor),
            secondBorderView.bottomAnchor.constraint(equalTo: secondButtonView.bottomAnchor),
            secondBorderView.leadingAnchor.constraint(equalTo: secondButtonView.leadingAnchor, constant: -0.5),
            secondBorderView.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
}

extension JAlertManager {
    @objc
    private func onTouchFirstButtonView(sender:UIButton) {
        if let completion = self.completion {
            completion(0)
        }
        
        alertView.removeFromSuperview()
    }
    
    @objc
    private func onTouchSecondButtonView(sender:UIButton) {
        if let completion = self.completion {
            completion(1)
        }
        
        alertView.removeFromSuperview()
    }
}
