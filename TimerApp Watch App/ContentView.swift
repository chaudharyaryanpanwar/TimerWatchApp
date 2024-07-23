//
//  ContentView1.swift
//  TimerApp Watch App
//
//  Created by Aryan Panwar on 21/07/24.
//

import SwiftUI
import WatchKit

struct ContentView: View {
    @EnvironmentObject var timerModel: TimerModel
    @State private var showSetTime = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            
            VStack(spacing : 10){
                Text(TimerModel.timeString(time : timerModel.timeRemaining))
                    .font(.system(size: 40 , weight: .bold , design: .rounded))
                    .foregroundStyle(.white)
                    .frame(height : 50)
                
                Button(action : timerModel.toggleTimer){
                    Image(systemName: timerModel.isRunning ? "pause.fill" : "play.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                }
                
                HStack( spacing : 20){
                    Button(action : timerModel.resetTimer){
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                            .frame(width : 40 , height : 40)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    
                    Button(action : { showSetTime = true}){
                        Image(systemName : "timer")
                            .font(.system(size : 18))
                            .foregroundStyle(.white)
                            .frame(width : 40 , height : 40)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }
                .padding(.top , 5)
            }
        }
        .sheet(isPresented: $showSetTime, content: {
            SetTimeView(timeRemaining: $timerModel.timeRemaining)
        })
    }
    

}

#Preview {
    ContentView()
        .environmentObject(TimerModel())
}
