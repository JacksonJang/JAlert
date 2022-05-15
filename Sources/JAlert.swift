import UIKit

public class JAlert: NSObject {
    public static let shared = JAlert()
    
    var alertView:BaseUIView? = nil
    
    public weak var delegate: JAlertDelegate? // delegate
    
    private var config:JConfig = JConfig()
    
    /*
        withAlphaComponet set backgroundColor of dimView
     */
    var withAlphaComponent:CGFloat = 0.4 {
        didSet{
            dimView.backgroundColor = UIColor.black.withAlphaComponent(withAlphaComponent)
        }
    }
    
    lazy var dimView:BaseUIView = {
        let view = BaseUIView()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(withAlphaComponent)
        
        return view
    }()
    
}

extension JAlert {
    public func configuration(config:JConfig) {
        self.config = config
    }
    
    public func show() {
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
        }
    }
    
    public func hide() {
        
    }
}

extension JAlert {
    private func createJAlert(){
        alertView = BaseUIView()
        
        setupDimView()
    }
    
    private func setupDimView() {
        if let alertView = alertView {
            alertView.addSubview(dimView)
            
            NSLayoutConstraint.activate([
                dimView.topAnchor.constraint(equalTo: alertView.topAnchor),
                dimView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
                dimView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
                dimView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor)
            ])
        }
    }
    
    private func setupContentView() {
        if let alertView = alertView {
            let contentView = BaseUIView()
            
            alertView.addSubview(contentView)
        }
    }
}
