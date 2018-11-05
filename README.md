# SwiftUIDebug

[![CI Status](http://img.shields.io/travis/EMart86/SwiftUIDebug.svg?style=flat)](https://travis-ci.org/EMart86/SwiftUIDebug)
[![Version](https://img.shields.io/cocoapods/v/SwiftUIDebug.svg?style=flat)](http://cocoapods.org/pods/SwiftUIDebug)
[![License](https://img.shields.io/cocoapods/l/SwiftUIDebug.svg?style=flat)](http://cocoapods.org/pods/SwiftUIDebug)
[![Platform](https://img.shields.io/cocoapods/p/SwiftUIDebug.svg?style=flat)](http://cocoapods.org/pods/SwiftUIDebug)

![Animation](https://thumbs.gfycat.com/MedicalTenderGermanspaniel-size_restricted.gif)

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

To add a log entry to the default log provider, simply call:

```Swift
SwiftLogProvider.shared.add(SwiftLog(Date(), "..."))
```

## Customization

Since the Log View is embedded in the EMTransformableNavigationController, you can add custom navigation items by implementing the SwiftUIDebugNavigationItemProviderProtocol. Than add your implementation as follows:

```Swift
SwiftUIDebug.debugController(with: self, navigationItemProvider: 'YourCustomImplementationOfSwiftUIDebugNavigationItemProviderProtocol')
```

You can also use a custom implementation for your log provider:

```Swift
SwiftUIDebug.debugController(with: self,
                             viewModel: SwiftLogViewModel(provider: 'YourCustomImplementationOfSwiftLogProviderProtocol')
                             navigationItemProvider: 'YourCustomImplementationOfSwiftUIDebugNavigationItemProviderProtocol')
```

## Author

eberl_ma@gmx.at

## License

SwiftUIDebug is available under the MIT license. See the LICENSE file for more info.
