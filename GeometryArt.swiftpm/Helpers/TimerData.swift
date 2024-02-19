//
//  TimerData.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 26/01/24.
//

import Foundation

class TimerData: ObservableObject {
    
    @Published var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @Published var running = false
    
    public func startTimer() {
        timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        running = true
    }
    
    public func pauseTimer() {
        timer.upstream.connect().cancel()
        running = false
    }
}
