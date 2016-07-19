# Saystack

Saystack is a collection of simple classes and extensions for most common uses in any iOS Swift project. It is a Swift counterpart to [Haystack](https://github.com/legoless/Haystack). Saystack currently supports Swift 2.x. Swift 3.x version will be released once apps can be deployed to the App Store.

Saystack adds convenience Swift API's to multiple frameworks, including UIKit and Foundation.

Few examples:

- UIImage resizing and loading
- Searching for parent view types in UIView

```swift
@IBAction func tableCellButtonTap(sender: UIButton) {
    guard let cell = sender.parentTableViewCell() else { return }
    
    let indexPath = self.tableView.indexPathForCell(cell)
    
    // Use IndexPath
}
```

- Random number generation
- Shuffling array

```swift

var array = [ 1, 2, 3, 4, 5 ]
array.shuffle()

print(array) // Prints [ 5, 2, 3, 1, 4 ]
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
