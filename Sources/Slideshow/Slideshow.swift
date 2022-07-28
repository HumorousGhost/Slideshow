//
//  Slideshow.swift
//
//
//  Created by HumorousGhost on 2022/7/28.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Slideshow<Data, ID, Content>: View where Data: RandomAccessCollection, ID: Hashable, Content: View {
    
    @ObservedObject
    private var viewModel: SlideshowViewModel<Data, ID>
    private let content: (Data.Element) -> Content
    
    public var body: some View {
        GeometryReader { proxy -> AnyView in
            viewModel.viewSize = proxy.size
            return AnyView(generateContent(proxy: proxy))
        }.clipped()
    }
    
    @ViewBuilder
    private func generateContent(proxy: GeometryProxy) -> some View {
        HStack(spacing: viewModel.spacing) {
            ForEach(viewModel.data, id: viewModel.dataId) {
                content($0)
                    .frame(width: viewModel.itemWidth)
                    .scaleEffect(x: 1, y: viewModel.itemScaling($0), anchor: .center)
            }
        }
        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .leading)
        .offset(x: viewModel.offset)
        .gesture(viewModel.dragGesture)
        .animation(viewModel.offsetAnimation, value: viewModel.offset)
        .onReceive(timer: viewModel.timer, perform: viewModel.receiveTimer)
        .onReceiveAppLifeCycle(perform: viewModel.setTimerActive)
    }
}

// MARK: - Initializers
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Slideshow {
    public init(_ data: Data,
                id: KeyPath<Data.Element, ID>,
                index: Binding<Int> = .constant(0),
                spacing: CGFloat = 10,
                headspace: CGFloat = 10,
                sidesScaling: CGFloat = 0.8,
                isWrap: Bool = false,
                autoScroll: SlideshowAutoScroll = .inactive,
                canMove: Bool = true,
                @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.viewModel = SlideshowViewModel(data, id: id, index: index, spacing: spacing, headspace: headspace, sidesScaling: sidesScaling, isWrap: isWrap, autoScroll: autoScroll, canMove: canMove)
        self.content = content
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Slideshow where ID == Data.Element.ID, Data.Element: Identifiable {
    public init(_ data: Data,
                index: Binding<Int> = .constant(0),
                spacing: CGFloat = 10,
                headspace: CGFloat = 10,
                isWrap: Bool = false,
                sidesScaling: CGFloat = 0.8,
                autoScroll: SlideshowAutoScroll = .inactive,
                canMove: Bool = true,
                @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.viewModel = SlideshowViewModel(data, index: index, spacing: spacing, headspace: headspace, sidesScaling: sidesScaling, isWrap: isWrap, autoScroll: autoScroll, canMove: canMove)
        self.content = content
    }
}

@available(iOS 14.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct Slideshow_LibraryContent: LibraryContentProvider {
    let Datas = Array(repeating: _Item(color: .red), count: 3)
    @LibraryContentBuilder var views: [LibraryItem] {
        LibraryItem(Slideshow(Datas, content: { _ in }), title: "Slideshow", category: .control)
        LibraryItem(Slideshow(Datas, index: .constant(0), spacing: 10, headspace: 10, isWrap: false, sidesScaling: 0.8, autoScroll: .inactive, canMove: true, content: { _ in }), title: "Slideshow full parameters", category: .control)
    }
    
    struct _Item: Identifiable {
        let id = UUID()
        let color: Color
    }
}
