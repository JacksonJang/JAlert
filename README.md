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
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/32906abb85159b13efe61e4ec4f1ca1f346168aa/JAlert1.png" width="293px" height="633px"> |
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
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/32906abb85159b13efe61e4ec4f1ca1f346168aa/JAlert2.png" width="293px" height="633px"> |
```swift
let alert = JAlert(title: "Title", message: "Content", alertType: .confirm)
  
alert.setButton(actionName: "OK", cancelName: "Cancel", onActionClicked: {
  print("onActionClicked")
}, onCancelClicked: {
  print("onCancelClicked")
})

alert.show()
```
---

| multi |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/32906abb85159b13efe61e4ec4f1ca1f346168aa/JAlert3.png" width="293px" height="633px"> |
```swift
let alert = JAlert(title: "Title", message: "Content", alertType: .multi)
  
alert.setMultiButton(titles: ["OK", "Cancel", "Something"])

alert.show()
```

if you want to use button event when you choose multi Type, you have to add JAlertDelegate.

```swift
let alert = JAlert(title: "Title", message: "Content", alertType: .mulit)
  
alert.setMultiButton(titles: ["OK", "Cancel", "Something"])
alert.delegate = self

alert.show()


extension SomethingController:JAlertDelegate {
    func alertView(_ alertView: JAlert, clickedButtonAtIndex buttonIndex: Int) {
        print("buttonIndex : ", buttonIndex)
    }
}
```

### Public Proerties (You can customize Alert View!)
```swift
public weak var delegate: JAlertDelegate? // delegate
    
public var appearType: AppearType = .default
public var disappearType: DisappearType = .default
    
public var cornerRadius: CGFloat = 8.0
public var textAlignment: NSTextAlignment = .center
public var alertViewBackgroundColor: UIColor = .white
public var actionButtonIndex = 0
public var animationWithDuration:CGFloat = 0.3
  
public var isUseBackgroundView = true
public var isUseSeparator = true
public var isAnimation = true
    
public var titleSideMargin: CGFloat = 20.0
public var titleTopMargin: CGFloat = 20.0
public var titleToMessageSpacing: CGFloat = 20.0
public var messageSideMargin: CGFloat = 20.0
public var messageBottomMargin: CGFloat = 20.0
```
## Author

JacksonJang, hyo961015@naver.com

## License

JAlert is available under the MIT license. See the LICENSE file for more info.



