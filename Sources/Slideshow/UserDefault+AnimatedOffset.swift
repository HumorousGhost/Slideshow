//
//  UserDefaults+AnimatedOffset.swift
//  
//
//  Created by HumorousGhost on 2022/7/28.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
internal extension UserDefaults {
    private struct Keys {
        static let isAnimatedOffset = "Slideshow+isAnimatedOffset"
    }
    
    static var isAnimatedOffset: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isAnimatedOffset)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.isAnimatedOffset)
        }
    }
    
}
