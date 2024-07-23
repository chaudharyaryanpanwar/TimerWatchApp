//
//  TimerWidget.swift
//  TimerWidget
//
//  Created by Aryan Panwar on 21/07/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
            SimpleEntry(date: Date(), timeRemaining: 600)
        }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), timeRemaining: 600)
    }
    

//    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: configuration)
//    }
//   
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let currentDate = Date()
                let entry = SimpleEntry(date: currentDate, timeRemaining: 600)
                let timeline = Timeline(entries: [entry], policy: .never)
        return timeline
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


    func recommendations() -> [AppIntentRecommendation<ConfigurationAppIntent>] {
        // Create an array with all the preconfigured widgets to show.
        [AppIntentRecommendation(intent: ConfigurationAppIntent(), description: "a timer app")]
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let timeRemaining: Int
    var isRunning : Bool
    init(date: Date, timeRemaining: Int, isRunning: Bool = false) {
        self.date = date
        self.timeRemaining = timeRemaining
        self.isRunning = isRunning
    }
}

struct TimerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        HStack {
            Text("\(timeString(time: entry.timeRemaining))")
                .font(.system(size: 20 , weight: .bold , design : .rounded ))
        
                
            Text( entry.isRunning ? "Playing" : "Paused")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
                
        }
//        .padding()
//        .background(.gray)
//        .clipShape(.rect(cornerRadius: 10))
    }
    
    private func timeString(time : Int) -> String {
        let minutes = time  / 60
        let seconds = time % 60
        return String(format : "%02d:%02d" , minutes , seconds)
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
    SimpleEntry(date: Date(), timeRemaining: 600)
}




