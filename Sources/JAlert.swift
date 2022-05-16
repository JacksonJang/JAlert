import UIKit

public let JAlert = JAlertManager.shared

public class JAlertManager: NSObject {
    public static let shared = JAlertManager()
    
    public weak var delegate: JAlertDelegate? // delegate
    
    public var leftMarign:CGFloat = 20.0
    public var rightMargin:CGFloat = 20.0
    public var cornerRadius:CGFloat = 10.0
    public var contentBackgroundColor:UIColor = .white
    
    //BackgroundColor of dimView
    var withAlphaComponent:CGFloat = 0.4 {
        didSet{
            dimView.backgroundColor = UIColor.black.withAlphaComponent(withAlphaComponent)
        }
    }
    
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
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var messageLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    private var contentView:BaseUIView!
    
}

extension JAlertManager {
    public func configuration(config:JConfig) {
        self.config = config
    }
    
    public func show(title:String = "", message:String = "") {
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
            
            //TODO: Temporary data
            titleLabel.text = "Title Example"
            messageLabel.text = "Message Example"
            
            setupContentConstraints()
        }
    }
    
    public func hide() {
        
    }
}

extension JAlertManager {
    private func createJAlert(){
        alertView = BaseUIView()
        
        setupDimView()
        setupContentView()
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
    
    private func setupContentView() {
        contentView = BaseUIView()
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = cornerRadius
        contentView.backgroundColor = contentBackgroundColor
        
        setupTitleLabel()
        
        alertView.addSubview(contentView)
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: titleTopMargin),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leftMarign),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -rightMargin)
        ])
    }
    
    private func setupContentConstraints() {
        setupContentHeightConstraints()
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor),
            contentView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: leftMarign),
            contentView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -rightMargin),
        ])
    }
    
    private func setupContentHeightConstraints() {
        titleLabel.frame.size = alertView.frame.size
        labelHeightToFit(titleLabel)
        
        messageLabel.frame.size = alertView.frame.size
        labelHeightToFit(messageLabel)
        
        let contentViewHeight:CGFloat = titleTopMargin + titleLabel.frame.height + betweenTitleAndMessageMargin + messageLabel.frame.height + messageBottomMargin
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: contentViewHeight)
        ])
    }
}

extension JAlertManager {
    private func labelHeightToFit(_ label: UILabel) {
        label.frame.size = CGSize(width: label.frame.size.width,
                                  height: CGFloat.greatestFiniteMagnitude)
        label.sizeToFit()
    }
}
