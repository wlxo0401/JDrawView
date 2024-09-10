# JDrawView

JDrawView is a lightweight and flexible drawing view for iOS applications. It provides an easy-to-use interface for implementing drawing functionality in your iOS apps.

## Features

- Simple and intuitive drawing interface
- Customizable line color and width
- Support for adding horizontal and vertical dash lines
- Ability to clear the drawing
- Convert drawing to UIImage
- Copy drawing to clipboard

## Example
### Function
<img src="https://github.com/user-attachments/assets/1c261e9f-6930-4e4a-94c4-6cf6ff97ab21" width="300" alt="ItemScrollView 데모">

### Copy
<img src="https://github.com/user-attachments/assets/61543340-5f31-40c1-adc7-f79fc0e09a86" width="500" alt="ItemScrollView 데모">



## Requirements

- iOS 13.0+
- Swift 5.0+

## Installation

JDrawView is available through [Swift Package Manager](https://swift.org/package-manager/).

Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/wlxo0401/JDrawView.git", .upToNextMajor(from: "1.0.4"))
]
```

## Usage

1. Import the module in your Swift file:

```swift
import JDrawView
```

2. Create and add a JDrawView to your view hierarchy:

```swift
let drawView = JDrawView(frame: view.bounds)
view.addSubview(drawView)
```

3. Customize the drawing:

```swift
// Set line color
drawView.setDrawColor(color: .red)

// Set line width
drawView.setDrawWidth(width: 5.0)

// Add dash lines
drawView.setHorizonDashLine(set: true)
drawView.setVerticalDashLine(set: true)
```

4. Get the drawing as an image:

```swift
let image = drawView.asImage()
```

5. Clear the drawing:

```swift
drawView.clearDrawing()
```

## Example

```swift
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let drawView = JDrawView()
        view.addSubview(drawView)

        drawView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            drawView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            drawView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            drawView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            drawView.heightAnchor.constraint(equalTo: drawView.widthAnchor),
        ])

        drawView.setDrawColor(color: .blue)
        drawView.setDrawWidth(width: 3.0)
    }
}
```

## Contribution

Contributions are welcome! Please feel free to submit a Pull Request.
