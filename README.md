# Saystack

[![Issues on Waffle](https://img.shields.io/badge/issues%20on-Waffle-blue.svg)](http://waffle.io/legoless/Saystack)
[![Swift Code](https://img.shields.io/badge/code%20in-Swift-orange.svg)](http://github.com/legoless/ViewModelable)
[![Build Status](https://travis-ci.org/Legoless/Saystack.svg)](https://travis-ci.org/legoless/Saystack)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Pod Version](http://img.shields.io/cocoapods/v/Saystack.svg?style=flat)](http://cocoadocs.org/docsets/Saystack/)
[![Pod Platform](http://img.shields.io/cocoapods/p/Saystack.svg?style=flat)](http://cocoadocs.org/docsets/Saystack/)
[![Pod License](http://img.shields.io/cocoapods/l/Saystack.svg?style=flat)](http://opensource.org/licenses/MIT)

Saystack is a collection of classes and extensions for most common uses in any Swift project (mainly directed at iOS). It is a Swift counterpart to [Haystack](https://github.com/legoless/Haystack), which has been deprecated.

Saystack adds many simple convenience methods to Swift API's. Multiple iOS and macOS frameworks are extended, including UIKit and Foundation. Both macOS and iOS are supported, but the framework is mainly targeting iOS, as macOS does not support UIKit.

### Foundation

- Simple Email validation

```swift
let email1 = "some@example.com".isValidEmail // true
let email2 = "some@example".isValidEmail // false
let email3 = "1231241231".isValidEmail // false
let email3 = "@example.com".isValidEmail // false
```

- Pseudo Random number generation

```swift
// Random Integer between 0 and 1000
let rand1 = Int.random(0, upper: 1000)
// Random Integer between -1000 and 1000
let rand2 = Int.random(-1000, upper: 1000)

// Single Precision random between 0.00 and 1.00
let rand2 = Float.random()
// Double Precision random between 0.00 and 1.00
let rand3 = Double.random()
```

- Array Utilities

```swift
//
// Shuffling
//
var array = [ 1, 2, 3, 4, 5 ]
array.shuffle()

// Prints [ 5, 2, 3, 1, 4 ]
print(array)
let shuffled = [ 1, 2, 3, 4, 5 ].shuffled()

//
// Unique elements
//
let uniqueArray = [ 1, 2, 1, 2, 4, 5 ].unique()
// Prints [ 1, 2, 4, 5 ]
print(uniqueArray)

struct Person {
    var name : String
}

let people = [ Person(name: "John"), Person(name: "John"), Person(name: "Mark"), Person(name: "John") ]
let distinctArrayByProperty = people.distinct({ $0.name })
// Prints [ Person("John"), Person("Mark") ]
print(distinctArrayByProperty)
```

### UIKit

Saystack provides several common UIKit extensions (not available on macOS).

- Environment detection

```swift
let environment = UIApplication.environment

if environment == .testFlight {
    ...
}
```

- `UIImage` resizing

```swift
let image = UIImage(named: "test-image.png")!
let resized = image.resize (CGSize(width: 100, height: 100))
```

- Searching for parent view types in `UIView`

```swift
@IBAction func tableCellButtonTap(sender: UIButton) {
    guard let cell = sender.parentTableViewCell() else { return }
    
    let indexPath = self.tableView.indexPathForCell(cell)
    
    // Use IndexPath
}
```

- Device information

```swift
let device = UIDevice.current.modelName

// Will use AdSupport.framework if available at runtime, otherwise vendorId.
let identifier = UIDevice.current.deviceIdentifier
```

Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [dal@unifiedsense.com](mailto:dal@unifiedsense.com)

License
======

**Saystack** is available under the **MIT** license. See [LICENSE](https://github.com/Legoless/Saystack/blob/master/LICENSE) file for more information.
