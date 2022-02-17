# JAlert

[![Version](https://img.shields.io/cocoapods/v/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)
[![License](https://img.shields.io/cocoapods/l/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)
[![Platform](https://img.shields.io/cocoapods/p/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-FF9966.svg?style=plastic)](https://swift.org/package-manager/)

## Overview

JAlert is a simple, customizable Alert View written in Swift.
We can choose the type we want and use it.

## Preview
| Type |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/5b60cf21ac58bc87ac81adc1e245071092570ab9/Demo1.gif" width="293px" height="633px"> |

---

| Properties |
|---|
|<img src = "https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/5b60cf21ac58bc87ac81adc1e245071092570ab9/Demo2.gif" width="293px" height="633px"> |

## CocoaPods

JAlert is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JAlert'
```

## Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate JAlert into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/JacksonJang/JAlert.git")
]
```

## Usage
### Quick Start

```swift
import JAlert

class ExampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //We can choose Type1 or Type2
        //createType1()
        //createType2()
    }

    func createType1(){
        let alert = JAlert(
            title: "title", 
            message: "message", 
            buttons: ["OK"], 
            onButtonClicked: { index in
                print("index : \(index)")
        })
        
        alert.show()
    }

    func createType2(){
        let alert = JAlert(
            title: "title", 
            message: "message", 
            alertType: .default
        )
        alert.setButton(
            actionName: "OK",
            cancelName: "Cancel"
        )
        alert.onButtonClicked = { index in
            print("index : \(index)")
        }
        alert.show()
    }
}
```

## Contribution

Discussion and pull requests are welcomed !

## License

JAlert is available under the MIT license. See the LICENSE file for more info.



