# JAlert

[![Version](https://img.shields.io/cocoapods/v/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)
[![License](https://img.shields.io/cocoapods/l/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)
[![Platform](https://img.shields.io/cocoapods/p/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)

## Overview

JAlert is a simple, customizable Alert View written in Swift.
You can choose the type you want and use it.

## Installation

JAlert is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JAlert'
```

## Demos
| Type |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/5b60cf21ac58bc87ac81adc1e245071092570ab9/Demo1.gif" width="293px" height="633px"> |

---

| Properties |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/5b60cf21ac58bc87ac81adc1e245071092570ab9/Demo2.gif" width="293px" height="633px"> |

## Usage

> First of all, import the module

```swift
import JAlert
```

### AlertType Usage

| default |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/1f498a112eba20bb9d34bfe8701eb10c67b11249/JAlert1.png" width="293px" height="633px"> |
```swift
let alert = JAlert(title: "title", message: "message", alertType: .default)
alert.setButton(actionName: "OK")
alert.show()
```
---

| confirm |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/1f498a112eba20bb9d34bfe8701eb10c67b11249/JAlert2.png" width="293px" height="633px"> |
```swift
let alert = JAlert(title: "title", message: "message", alertType: .confirm)
alert.setButton(actionName: "OK", cancelName: "Cancel", onActionClicked: {
  print("onActionClicked")
}, onCancelClicked: {
  print("onCancelClicked")
})
alert.show()
```
---

| submit |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/1f498a112eba20bb9d34bfe8701eb10c67b11249/JAlert3.png" width="293px" height="633px"> |
```swift
let alert = JAlert(title: "title", message: "message", alertType: .submit)
alert.setButton(actionName: "OK", cancelName: "Cancel", onActionClicked: {
    print("text : \(alert.getSubmitText())")
    print("onActionClicked")
}, onCancelClicked: {
    print("onCancelClicked")
})
alert.show()
```
---

| date |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/1f498a112eba20bb9d34bfe8701eb10c67b11249/JAlert4.png" width="293px" height="633px"> |
```swift
let alert = JAlert(title: "title", message: "message", alertType: .date)
alert.setButton(actionName: "OK", cancelName: "Cancel", onActionClicked: {
    print("date : \(alert.getDate())")
    print("onActionClicked")
})
alert.show()
```
---

| image |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/1f498a112eba20bb9d34bfe8701eb10c67b11249/JAlert5.png" width="293px" height="633px"> |
```swift
let alert = JAlert(title: "title", message: "message", alertType: .image)
alert.urlString = "https://cdn.pixabay.com/photo/2022/01/02/04/37/animal-6909429_1280.jpg"
alert.setButton(actionName: "OK", onActionClicked: {
    print("onActionClicked")
})
alert.show()
```
---


### if you want to use button event when managing as a delegate, you can add JAlertDelegate.

| Apply Delegate Example |
|---|
```swift
let alert = JAlert(title: "title", message: "message", alertType: .default)

alert.setButton(actionName: "OK")
alert.delegate = self

alert.show()


extension SomethingController:JAlertDelegate {
    func alertView(_ alertView: JAlert, clickedButtonAtIndex buttonIndex: Int) {
        print("buttonIndex : ", buttonIndex)
    }
}
```

### Public Function
```swift
public func setButton(
    actionName:String, 
    cancelName:String? = nil, 
    onActionClicked: (() -> Void)? = nil, 
    onCancelClicked: (() -> Void)? = nil
)
public func getSubmitText() -> String
public func show()
```

### Public Proerties (You can customize Alert View!)
```swift
// MARK: Public Proerties (You can customize Alert View!)
    public weak var delegate: JAlertDelegate? // delegate
    
    //Setting animation
    public var appearType: AppearType = .default
    public var disappearType: DisappearType = .default
    
    //AlertView Property
    public var alertBackgroundColor: UIColor = .white
    public var buttonBackgroundColor: UIColor = .white
    public var borderWidth: CGFloat = 1.0
    public var borderColor: CGColor = UIColor.black.cgColor
    public var cornerRadius: CGFloat = 8.0
    public var textAlignment: NSTextAlignment = .center
    public var animationWithDuration:CGFloat = 0.3
    public var isUseButtonBackground = true
    public var isUseDimView = true
    public var isUseSeparator = true
    public var isUseAnimation = true
    public var isUseBorder = false
    
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
    
    //Margin
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
    
    //Type Property
    public var dateFormat = "yyyy-MM-dd HH:mm:ss" // Use for ".date" type.(default: "yyyy-MM-dd HH:mm:ss")
    public var language:Language = .en_US // Use for ".date" type.(default: .en_US)
    public var image:UIImage = UIImage()
    public var submitBorderWidth: CGFloat = 0.5
    public var submitBorderColor: CGColor = UIColor.black.cgColor
    public var submitViewHeight:CGFloat = 150
    public var datePickerViewHeight:CGFloat = 250
```
## Contribution

Discussion and pull requests are welcomed !

## License

JAlert is available under the MIT license. See the LICENSE file for more info.



