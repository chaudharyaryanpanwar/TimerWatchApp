//
//  ContentView.swift
//  TimerApp Watch App
//
//  Created by Aryan Panwar on 20/07/24.
//

import SwiftUI


struct ContentView: View {
    @State private var timeRemaining = 600
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var showSetTime = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                Text(timeString(time: timeRemaining))
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(height: 50)
                
                    
                Button(action: toggleTimer) {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                }
                
                HStack(spacing: 20) {
                    Button(action: resetTimer) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    
                    Button(action: { showSetTime = true }) {
                        Image(systemName: "timer")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 5)
            }
        }
        .sheet(isPresented: $showSetTime) {
            SetTimeView(timeRemaining: $timeRemaining)
        }
    }
    
    func toggleTimer() {
        if isRunning {
            timer?.invalidate()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer?.invalidate()
                    isRunning = false
                    WKInterfaceDevice.current().play(.notification)
                }
            }
        }
        isRunning.toggle()
    }
    
    func resetTimer() {
        timer?.invalidate()
        isRunning = false
        timeRemaining = 600
    }
    
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}





#Preview {
    ContentView()
}
