//
//  TimerModel.swift
//  TimerApp Watch App
//
//  Created by Aryan Panwar on 21/07/24.
//

import Foundation
import SwiftUI

class TimerModel : ObservableObject {
    @Published var timeRemaining : Int = 600
    @Published var isRunning : Bool = false
    private var timer : Timer?
    
    func toggleTimer (){
        if self.isRunning {
            self.timer?.invalidate()
        } else {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {  Timer in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.timer?.invalidate()
                    self.isRunning = false
                    WKInterfaceDevice.current().play(.notification)
                }
            })
        }
        self.isRunning.toggle()
    }
    
    func resetTimer(){
        self.timer?.invalidate()
        self.isRunning = false
        self.timeRemaining = 600
    }
    
    static func timeString(time : Int )->String {
        let minutes  = time / 60
        let seconds = time % 60
        return String(format : "%02d:%02d", minutes , seconds)
    }
    
}
