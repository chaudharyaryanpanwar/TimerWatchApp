//
//  AppIntent.swift
//  TimerWidget
//
//  Created by Aryan Panwar on 21/07/24.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Timer App"
    static var description = IntentDescription("This is a timer app widget")
}
