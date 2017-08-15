# SwiftUIDebug

[![CI Status](http://img.shields.io/travis/eberl_ma@gmx.at/SwiftUIDebug.svg?style=flat)](https://travis-ci.org/eberl_ma@gmx.at/SwiftUIDebug)
[![Version](https://img.shields.io/cocoapods/v/SwiftUIDebug.svg?style=flat)](http://cocoapods.org/pods/SwiftUIDebug)
[![License](https://img.shields.io/cocoapods/l/SwiftUIDebug.svg?style=flat)](http://cocoapods.org/pods/SwiftUIDebug)
[![Platform](https://img.shields.io/cocoapods/p/SwiftUIDebug.svg?style=flat)](http://cocoapods.org/pods/SwiftUIDebug)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 9.0 or higher

## Installation

SwiftUIDebug is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftUIDebug'
```

## Example

Import the framework

```swift
import SwiftUIDebug
```

In a view controller, add it just like this:
```Swift
    SwiftUIDebug.debugController(with: self)
```

Or you can combine it with the shake gesture:
```Swift
override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
    if motion == .motionShake {
        SwiftUIDebug.debugController(with: self)
    }
}
```

## Author

eberl_ma@gmx.at, martin.eberl@styria.com

## License

SwiftUIDebug is available under the MIT license. See the LICENSE file for more info.
