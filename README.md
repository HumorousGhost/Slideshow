# Slideshow

This project is only for SwiftUI

An automatic scrolling carousel similar to how `ScrollView` is used

## Preview

![image](https://github.com/HumorousGhost/Slideshow/blob/main/slideshow_preview.gif)

## Supported Platforms

* iOS 13.0
* macOS 10.15
* tvOS 13.0
* watchOS 6.0

## Usage

```swift
    struct Item: Identifiable {
        let id = UUID()
        let image: String
        let title: String
    }
    
    let items = [
        Item(image: "image1", title: "first"),
        Item(image: "image2", title: "second"),
        Item(image: "image3", title: "third"),
        Item(image: "image4", title: "fourth")
    ]
    
    var body: some View {
        VStack {
            Spacer()
            Slideshow(items, spacing: 20, isWrap: true, autoScroll: .active(2)) { item in
                itemView(item: item)
                    .frame(width: 350, height: 200)
                    .cornerRadius(16)
            }
            .frame(width: UIScreen.main.bounds.width, height: 200)
            Spacer()
        }
    }
    
    @ViewBuilder
    func itemView(item: Item) -> some View {
        ZStack {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
        }
    }
```

## Installation

You can add Slideshow to an Xcode project by adding it as a package dependency

* From the **File** menu, select **Swift Packages** > **Add Package Dependency...**
* Enter https://github.com/HumorousGhost/Slideshow into the package repository URL text field.
* Link **Slideshow** to your application target.
