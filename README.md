# JAlert

[![Version](https://img.shields.io/cocoapods/v/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)
[![License](https://img.shields.io/cocoapods/l/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)
[![Platform](https://img.shields.io/cocoapods/p/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)

## Overview

if you need a customizable Alert, you can use "JAlert" easily.
I'd like to use easily for everyone through JAlert Library. 
When you have the features you want but not in JAlert, just send me your ask.

## Installation

JAlert is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JAlert'
```

## Usage

> if you want to use customizing alertView, you can choose "alertType" in JAlert Library.
> Actually, JAlert contains "Public Proerties" option.

first of all, Import the module

```swift
import JAlert
```

### AlertType Usage

| default |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/5409f65310b019fc36eed8dd2b2fcafa92e42368/JAlert1.png" width="293px" height="633px"> |
```swift
let alert = JAlert(title: "Title", message: "Content", alertType: .default)
  
alert.setButton(actionName: "OK", onActionClicked: {
  print("onActionClicked")
})

alert.show()
```
---

| confirm |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/5409f65310b019fc36eed8dd2b2fcafa92e42368/JAlert2.png" width="293px" height="633px"> |
```swift
let alert = JAlert(title: "Title", message: "Content", alertType: .confirm)
  
alert.setButton(actionName: "OK", cancelName: "Cancel", onActionClicked: {
  print("onActionClicked")
}, onCancelClicked: {
  print("onCancelClicked")
})

alert.show()
```

if you want to use button event when managing as a delegate, you can add JAlertDelegate.

```swift
let alert = JAlert(title: "Title", message: "Content", alertType: .default)

alert.setButton(actionName: "OK")
alert.delegate = self

alert.show()


extension SomethingController:JAlertDelegate {
    func alertView(_ alertView: JAlert, clickedButtonAtIndex buttonIndex: Int) {
        print("buttonIndex : ", buttonIndex)
    }
}
```
---

| submit |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/e7f4219aabf8b828de2cff756f81b96921c7f19d/JAlert3.png" width="293px" height="633px"> |
```swift
let alert = JAlert(title: "Title", message: "Content", alertType: .submit)
  
alert.setButton(actionName: "OK", cancelName: "Cancel", onActionClicked: {
  print("text : \(alert.getSubmitText())")
  print("onActionClicked")
}, onCancelClicked: {
  print("onCancelClicked")
})

alert.show()
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
public weak var delegate: JAlertDelegate? // delegate
    
public var appearType: AppearType = .default
public var disappearType: DisappearType = .default
    
public var cornerRadius: CGFloat = 8.0
public var textAlignment: NSTextAlignment = .center
public var alertBackgroundColor: UIColor = .white
public var animationWithDuration:CGFloat = 0.3
    
public var titleColor:UIColor = UIColor(red: 5.0/255.0, green: 0, blue: 153.0/255.0, alpha: 1.0)
public var messageColor:UIColor = UIColor(red: 5.0/255.0, green: 0, blue: 153.0/255.0, alpha: 1.0)
public var actionButtonColor:UIColor = UIColor.black
public var cancelButtonColor:UIColor = UIColor.black
  
public var isUseBackgroundView = true
public var isUseSeparator = true
public var isAnimation = true
    
public var titleSideMargin: CGFloat = 20.0
public var titleTopMargin: CGFloat = 20.0
public var titleToMessageSpacing: CGFloat = 20.0
public var messageSideMargin: CGFloat = 20.0
public var messageBottomMargin: CGFloat = 20.0
```
## Contribution

Discussion and pull requests are welcomed !

## License

JAlert is available under the MIT license. See the LICENSE file for more info.



