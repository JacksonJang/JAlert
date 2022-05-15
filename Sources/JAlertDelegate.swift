public protocol JAlertDelegate: AnyObject {
    func alertView(_ alertView: JAlert, clickedButtonAtIndex buttonIndex: Int)
}
