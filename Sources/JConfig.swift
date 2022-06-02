import UIKit

public class JConfig {
        
    //MARK: Margin
    //SuperView of JAlert
    public var alertLeftMarign:CGFloat = 20.0
    public var alertRightMargin:CGFloat = 20.0
    //Title
    public var titleTopMargin:CGFloat = 10.0
    public var titleLeftMargin:CGFloat = 10.0
    public var titleRightMargin:CGFloat = 10.0
    //Message
    public var messageLeftMargin:CGFloat = 10.0
    public var messageRightMargin:CGFloat = 10.0
    public var messageBottomMargin:CGFloat = 10.0
    //Etc
    public var betweenTitleAndMessageMargin:CGFloat = 10.0
    
    //MARK: Alert Properties
    public var contentCornerRadius:CGFloat = 10.0
    public var backgroundColor:UIColor = .white
    public var contentBorderWidth:CGFloat = 0.0
    public var contentBorderColor:UIColor = .black
    public var backgroundWithAlphaComponent:CGFloat = 0.4
    public var borderColor:UIColor = .gray
    
    //MARK: UILabel Properties
    public var titleFont:UIFont = .systemFont(ofSize: 16)
    public var messageFont:UIFont = .systemFont(ofSize: 16)
    public var buttonsFont:[UIFont] = [
        .systemFont(ofSize: 16),
        .systemFont(ofSize: 16)
    ]
    
    public init() {
        
    }
}
