# JAlert

[![Version](https://img.shields.io/cocoapods/v/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)
[![License](https://img.shields.io/cocoapods/l/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)
[![Platform](https://img.shields.io/cocoapods/p/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)

## Overview

if you need a customizable Alert, you can use "JAlert" easily.

## Installation

JAlert is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JAlert'
```

## How to use?

```swift
let alert = JAlert(title: "Title", message: "Content", alertType: .default) ;//Write title and message, then select your alertType 
alert.delegate = self
alert.show()
```

## Author

JacksonJang, hyo961015@naver.com

## License

JAlert is available under the MIT license. See the LICENSE file for more info.



