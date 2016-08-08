# Saystack

Saystack is a collection of simple classes and extensions for most common uses in any iOS Swift project. It is a Swift counterpart to [Haystack](https://github.com/legoless/Haystack). Saystack currently supports Swift 2.x. Swift 3.x version will be released once apps can be deployed to the App Store with Swift 3.

Saystack adds convenience methods to Swift API's. Multiple frameworks are extended, including UIKit and Foundation. Both OS X and iOS are supported, but the framework is mainly targeting iOS.

### Foundation

- Random number generation

```swift
// Random Integer between 0 and 1000
let rand1 = Int.random(0, upper: 1000)

// Random Float between 0.00 and 1.00
let rand2 = Float.random()
```

- Shuffling arrays

```swift
var array = [ 1, 2, 3, 4, 5 ]
array.shuffle()

print(array) // Prints [ 5, 2, 3, 1, 4 ]

let shuffled = [ 1, 2, 3, 4, 5 ].shuffled()
```

### UIKit

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
