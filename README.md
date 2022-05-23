# JAlert

[![Version](https://img.shields.io/cocoapods/v/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)
[![License](https://img.shields.io/cocoapods/l/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)
[![Platform](https://img.shields.io/cocoapods/p/JAlert.svg?style=flat)](https://cocoapods.org/pods/JAlert)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-FF9966.svg?style=plastic)](https://swift.org/package-manager/)

## Overview

JAlert is a simple, customizable Alert View written in Swift.
We can choose the type we want and use it.

## Preview
| default | buttonTitles |
|---|---|
| <img src="https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/0fa232e39f8eceaf13e261519a5ad55df5d0e1e4/JAlert1.png"  width="300"> | <img src="https://gist.githubusercontent.com/JacksonJang/050927a21f291ad4d65cac0e2df4b4c9/raw/0fa232e39f8eceaf13e261519a5ad55df5d0e1e4/JAlert2.png"  width="300" > 

---
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
        JAlert.show(title: "title test",
                    message: "message test")
    }

    func createType2(){
        JAlert.show(title: "title test",
                        message: "message test",
                        buttonTitles: ["YES", "NO"]) 
        { (index) in
            print("index : ", index)
        }
    }
}
```

## Contribution

Discussion and pull requests are welcomed !

## License

JAlert is available under the MIT license. See the LICENSE file for more info.



