import UIKit

public let JAlert = JAlertManager.shared

public class JAlertManager: NSObject {
    public static let shared = JAlertManager()
    
    public weak var delegate: JAlertDelegate? // delegate
    
    public var alertLeftMarign:CGFloat = 20.0
    public var alertRightMargin:CGFloat = 20.0
    public var cornerRadius:CGFloat = 10.0
    public var contentBackgroundColor:UIColor = .white
    
    //BackgroundColor of dimView
    var withAlphaComponent:CGFloat = 0.4 {
        didSet{
            dimView.backgroundColor = UIColor.black.withAlphaComponent(withAlphaComponent)
        }
    }
    
    public var spacing:CGFloat = 15.0
    public var titleTopMargin:CGFloat = 10.0
    public var titleLeftMargin:CGFloat = 10.0
    public var titleRightMargin:CGFloat = 10.0
    public var betweenTitleAndMessageMargin:CGFloat = 10.0
    public var messageLeftMargin:CGFloat = 10.0
    public var messageRightMargin:CGFloat = 10.0
    public var messageBottomMargin:CGFloat = 10.0
    
    private var titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byCharWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var messageLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        sv.layer.cornerRadius = cornerRadius
        sv.backgroundColor = contentBackgroundColor
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
        sv.distribution = .fill

        return sv
    }()
    
}

extension JAlertManager {
    public func configuration(config:JConfig) {
        self.config = config
    }
    
    public func show(title:String = "", message:String = "") {
        //TODO: Temporary data
        titleLabel.text = "Title Example"
        messageLabel.text = "Message Example"
        
        createJAlert()
        
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
    
    public func hide() {
        
    }
}

extension JAlertManager {
    private func createJAlert(){
        alertView = BaseUIView()
        
        setupDimView()
        setupContentStackView()
        setupCotentBottomBorderView()
    }
    
    private func setupDimView() {
        dimView = BaseUIView()
        dimView.backgroundColor = UIColor.black.withAlphaComponent(withAlphaComponent)
        
        alertView.addSubview(dimView)
        
        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: alertView.topAnchor),
            dimView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor)
        ])
    }
    
    private func setupContentStackView() {
        addTitleAndMessageToContentStackView()
        
        alertView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
        ])
    }
    
    private func addTitleAndMessageToContentStackView() {
        createSpacingView(spacing: titleTopMargin)
        contentStackView.addArrangedSubview(titleLabel)
        createSpacingView(spacing: betweenTitleAndMessageMargin)
        contentStackView.addArrangedSubview(messageLabel)
        createSpacingView(spacing: messageBottomMargin)
        
        setupTitleAndMessageConstraints()
    }
    
    private func setupTitleAndMessageConstraints() {
        if let contentStackView = titleLabel.superview {
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: titleLeftMargin),
                titleLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -titleRightMargin),
                messageLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: messageLeftMargin),
                messageLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -messageRightMargin)
            ])
        }
    }
    
    private func setupCotentBottomBorderView() {
        contentStackView.addArrangedSubview(cotentBottomBorderView)
        
        NSLayoutConstraint.activate([
            cotentBottomBorderView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 0),
            cotentBottomBorderView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: 0),
            cotentBottomBorderView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupButtonStackView() {
        
    }
}

extension JAlertManager {
    private func createSpacingView(spacing:CGFloat) {
        let spacingView:UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        contentStackView.addArrangedSubview(spacingView)
        
        NSLayoutConstraint.activate([
            spacingView.heightAnchor.constraint(equalToConstant: spacing)
        ])
    }
    
    private func labelHeightToFit(_ label: UILabel) {
        label.frame.size = CGSize(width: label.frame.size.width,
                                  height: CGFloat.greatestFiniteMagnitude)
        label.sizeToFit()
    }
}
