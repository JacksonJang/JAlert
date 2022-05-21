import UIKit

public let JAlert = JAlertManager.shared

public class JAlertManager: NSObject {
    public static let shared = JAlertManager()
    
    public weak var delegate: JAlertDelegate? // delegate
    
    public var firstButtonString:String = "OK"
    public var secondButtonString:String = "Cancel"
    
    private lazy var titleLabel:JPaddingLabel = {
        let label = JPaddingLabel(left: config.titleLeftMargin, right: config.titleRightMargin)
        
        label.lineBreakMode = .byCharWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var messageLabel:JPaddingLabel = {
        let label = JPaddingLabel(left: config.titleLeftMargin, right: config.titleRightMargin)
        
        label.lineBreakMode = .byCharWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    //MARK: Alert Default Properties
    private var title:String = ""
    private var message:String = ""
    
    //MARK: Private Properties
    private var config:JConfig = JConfig()
    
    //MARK: UI
    private var alertView:BaseUIView!
    private var dimView:BaseUIView!
    
    private lazy var contentStackView:UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.clipsToBounds = true
        sv.layer.masksToBounds = true
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.layer.cornerRadius = config.cornerRadius
        sv.backgroundColor = config.contentBackgroundColor
        return sv
    }()
    
    private var cotentBottomBorderView:UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        
        return view
    }()
    
    private lazy var buttonStackView:UIStackView = {
        let sv = UIStackView()

        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually

        return sv
    }()
    
    private var firstButtonView:UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var secondButtonView:UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var titleTopSpacingView:UIView!
    private var messageBottomSpacingView:UIView!
    
    public override init() {
        super.init()
        setupUI()
    }
    
    private func setupUI() {
        print("setupUI")
        createJAlert()
    }
}

extension JAlertManager {
    public func configuration(config:JConfig) {
        self.config = config
    }
    
    public func show(title:String = "",
                     message:String = "",
                     buttonTitles:[String] = []) {
        titleLabel.text = title
        messageLabel.text = message
        updateConfiguration()
        
        if let alertView = alertView,
           let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) {
            
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
    
    private func removeViewConstraints() {
        titleTopSpacingView.removeConstraints()
        messageBottomSpacingView.removeConstraints()
    }
    
    private func updateConfiguration() {
        removeViewConstraints()
        
        print("titleTopSpacingView constraints : ", titleTopSpacingView.constraints)
        
        NSLayoutConstraint.activate([
            titleTopSpacingView.heightAnchor.constraint(equalToConstant: config.titleTopMargin),
            messageBottomSpacingView.heightAnchor.constraint(equalToConstant: config.messageBottomMargin)
        ])
    }
}

extension JAlertManager {
    private func createJAlert(){
        alertView = BaseUIView()
        titleTopSpacingView = BaseUIView()
        messageBottomSpacingView = BaseUIView()
        
        setupDimView()
        setupContentStackView()
        setupBetweenCotentAndButtonBorderView()
        setupButtonStackView()
    }
    
    private func setupDimView() {
        dimView = BaseUIView()
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
        contentStackView.addArrangedSubview(titleTopSpacingView)
        contentStackView.addArrangedSubview(titleLabel)
        if #available(iOS 11.0, *) {
            contentStackView.setCustomSpacing(config.betweenTitleAndMessageMargin, after: titleLabel)
        }
        contentStackView.addArrangedSubview(messageLabel)
        contentStackView.addArrangedSubview(messageBottomSpacingView)
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
        let label = UILabel()
        let button = UIButton()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = firstButtonString
        button.addTarget(self, action: #selector(onTouchFirstButtonView(sender:)), for: .touchUpInside)
        
        [
            label,
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
                label.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: superView.centerYAnchor),
            ])
        }
    }
    
    private func setupSecondButtonView() {
        let label = UILabel()
        let button = UIButton()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = secondButtonString
        button.addTarget(self, action: #selector(onTouchSecondButtonView(sender:)), for: .touchUpInside)
        
        [
            label,
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
                label.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: superView.centerYAnchor),
            ])
        }
        
        setupSecondButtonLeftBorderView()
    }
    
    private func setupSecondButtonLeftBorderView() {
        let borderView = UIView()
        borderView.backgroundColor = .gray
        borderView.translatesAutoresizingMaskIntoConstraints = false
        
        secondButtonView.addSubview(borderView)
        
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: secondButtonView.topAnchor),
            borderView.bottomAnchor.constraint(equalTo: secondButtonView.bottomAnchor),
            borderView.leadingAnchor.constraint(equalTo: secondButtonView.leadingAnchor, constant: -0.5),
            borderView.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
}

extension JAlertManager {
    @objc
    private func onTouchFirstButtonView(sender:UIButton) {
        print("onTouchFirstButtonView")
        alertView.removeFromSuperview()
    }
    
    @objc
    private func onTouchSecondButtonView(sender:UIButton) {
        print("onTouchSecondButtonView")
        alertView.removeFromSuperview()
    }
}
