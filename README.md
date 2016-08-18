# Saystack

Saystack is a collection of simple classes and extensions for most common uses in any iOS Swift project. It is a Swift counterpart to [Haystack](https://github.com/legoless/Haystack). Saystack currently supports Swift 2.x. Swift 3.x version will be released once apps can be deployed to the App Store with Swift 3.

Saystack adds many convenience methods to Swift API's. Multiple frameworks are extended, including UIKit and Foundation. Both macOS and iOS are supported, but the framework is mainly targeting iOS, as macOS does not support UIKit.

### Foundation

- Random number generation

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
var array = [ 1, 2, 3, 4, 5 ]
array.shuffle()

// Prints [ 5, 2, 3, 1, 4 ]
print(array)
let shuffled = [ 1, 2, 3, 4, 5 ].shuffled()

let uniqueArray = [ 1, 2, 1, 2, 4, 5 ].unique()
// Prints [ 1, 2, 4, 5 ]
print(uniqueArray)
```

### UIKit

- Environment detection

```swift
let environment = UIApplication.environment

if environment == .TestFlight {
    ...
}
```

- UIImage resizing

```swift
let image = UIImage(named: "test-image.png")!
let resized = image.resize (CGSizeMake(100, 100))
```

- Searching for parent view types in UIView

```swift
@IBAction func tableCellButtonTap(sender: UIButton) {
    guard let cell = sender.parentTableViewCell() else { return }
    
    let indexPath = self.tableView.indexPathForCell(cell)
    
    // Use IndexPath
}
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
