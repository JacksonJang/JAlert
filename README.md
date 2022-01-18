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

| Animation : scale |
|---|
```swift
let alert = JAlert(title: "title", message: "message", alertType: .default)
alert.appearType = .scale
alert.disappearType = .scale
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



