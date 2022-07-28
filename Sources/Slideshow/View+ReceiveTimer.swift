//
//  View+ReceiveTimer.swift
//  
//
//  Created by HumorousGhost on 2022/7/28.
//

import SwiftUI
import Combine

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
typealias TimePublisher = Publishers.Autoconnect<Timer.TimerPublisher>

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    func onReceive(timer: TimePublisher?, perform action: @escaping (Timer.TimerPublisher.Output) -> Void) -> some View {
        Group {
            if let timer = timer {
                self.onReceive(timer) { value in
                    action(value)
                }
            } else {
                self
            }
        }
    }
}
