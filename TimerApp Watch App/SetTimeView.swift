//
//  SetTimeView.swift
//  TimerApp Watch App
//
//  Created by Aryan Panwar on 20/07/24.
//

import SwiftUI

struct SetTimeView: View {
    @Binding var timeRemaining: Int
    @State private var selectedMinutes = 10
    @State private var selectedSeconds = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Set Timer")
                .font(.headline)
                .padding(.bottom, 5)
            
            HStack(spacing: 0) {
                VStack {
                    Picker("Minutes", selection: $selectedMinutes) {
                        ForEach(0..<60) { minute in
                            Text("\(minute)").tag(minute)
                                .font(.title3)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 100)
                    .clipped()
                    
                    Text("min")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .frame(width: WKInterfaceDevice.current().screenBounds.width / 2)
                
                VStack {
                    Picker("Seconds", selection: $selectedSeconds) {
                        ForEach(0..<60) { second in
                            Text("\(second)").tag(second)
                                .font(.title3)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 100)
                    .clipped()
                    
                    Text("sec")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .frame(width: WKInterfaceDevice.current().screenBounds.width / 2)
            }
            .padding(.vertical, 5)
            
            Button(action: {
                timeRemaining = (selectedMinutes * 60) + selectedSeconds
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Set")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    SetTimeView(timeRemaining: .constant(500))
}
