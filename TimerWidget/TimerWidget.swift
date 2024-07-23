//
//  TimerWidget.swift
//  TimerWidget
//
//  Created by Aryan Panwar on 21/07/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    static var timeRemaining = 600
    static var isRunning : Bool = false
    static var lastUpdateTime :Date = Date()
    
    func placeholder(in context: Context) -> TimerEntry {
        TimerEntry(date : Date() , timeRemaining: Provider.timeRemaining , isRunning: Provider.isRunning)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> TimerEntry {
        TimerEntry(date : Date() , timeRemaining: Provider.timeRemaining , isRunning: Provider.isRunning)
    }
    

//    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: configuration)
//    }
//   
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<TimerEntry> {
        var entries : [TimerEntry] = []
        let currentDate = Date()
        
        if Provider.isRunning {
            let elapsedTime = Int(currentDate.timeIntervalSince(Provider.lastUpdateTime))
            Provider.timeRemaining = max(0 , Provider.timeRemaining - elapsedTime)
            Provider.lastUpdateTime = currentDate
            
            for i in 0..<60 {
                let entryDate = Calendar.current.date(byAdding: .second, value : i , to : currentDate)!
                let timeRemaining = max(0 , Provider.timeRemaining - i )
                let entry = TimerEntry(date : entryDate , timeRemaining : timeRemaining , isRunning : timeRemaining > 0 )
                entries.append(entry)
            }
        } else {
            let entry = TimerEntry(date : Date() , timeRemaining: Provider.timeRemaining , isRunning: Provider.isRunning)
            entries.append(entry)
        }
        
        
        return Timeline(entries: entries, policy: .atEnd)
    }
    
//    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        return Timeline(entries: entries, policy: .atEnd)
//    }

    private func getCurrentTimeRemaining() -> Int {
        return 600
    }
    
    private func isTimerRunning()-> Bool {
        return false
    }
    
    func recommendations() -> [AppIntentRecommendation<ConfigurationAppIntent>] {
        // Create an array with all the preconfigured widgets to show.
        [AppIntentRecommendation(intent: ConfigurationAppIntent(), description: "a timer app")]
    }
}

struct TimerEntry: TimelineEntry {
    let date: Date
    let timeRemaining : Int
    let isRunning : Bool
    
//    init(timerModel : TimerModel ){
//        self.date = Date()
//        self.timeRemaining = timerModel.timeRemaining
//        self.isRunning = timerModel.isRunning
//    }
}

struct TimerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        HStack {
            Text("\(timeString(time: entry.timeRemaining))")
                .font(.system(size: 20 , weight: .bold , design : .rounded ))
            HStack (spacing : 1) {
                Button(action : {
                    toggleTimer()
                } , label : {
                    Image(systemName: entry.isRunning ? "pause.fill" : "play.fill")
                    //                    .font(.system(size: 30))
                    //                    .foregroundStyle(.white)
                })
                Button(action : {
                    resetTimer()
                } , label : {
                    Image(systemName: "arrow.counterclockwise")
                    //                    .font(.system(size: 30))
                    //                    .foregroundStyle(.white)
                })
            }
        }
    }
    
    private func timeString(time : Int) -> String {
        let minutes = time  / 60
        let seconds = time % 60
        return String(format : "%02d:%02d" , minutes , seconds)
    }
    
    private func toggleTimer(){
        Provider.isRunning.toggle()
        if Provider.isRunning {
            Provider.lastUpdateTime = Date()
        }
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    private func resetTimer(){
        Provider.timeRemaining = 600
        Provider.isRunning = false
        Provider.lastUpdateTime = Date()
        WidgetCenter.shared.reloadAllTimelines()
    }
}

@main
struct TimerWidget: Widget {
    let kind: String = "TimerWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            TimerWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

#Preview(as: .accessoryRectangular) {
    
    TimerWidget()
} timeline: {
    TimerEntry(date : Date() , timeRemaining: 600 , isRunning: true )
}




