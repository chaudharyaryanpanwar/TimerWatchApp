//
//  TimerAppApp.swift
//  TimerApp Watch App
//
//  Created by Aryan Panwar on 20/07/24.
//

import SwiftUI

@main
struct TimerApp_Watch_AppApp: App {
    
    @StateObject private var timerModel = TimerModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environmentObject(timerModel)
            }
        }
    }
}
