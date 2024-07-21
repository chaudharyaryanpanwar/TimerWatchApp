//
//  SetTimeView1.swift
//  TimerApp Watch App
//
//  Created by Aryan Panwar on 21/07/24.
//

import SwiftUI

struct SetTimeView: View {
    @Binding var timeRemaining : Int
    @State private var selectedMinutes = 10
    @State private var selectedSeconds = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing : 5){
            Text("Set Timer")
                .font(.headline)
                .padding(.bottom , 5)
            
            HStack (spacing : 0){
                VStack {
                    Picker("Minutes" , selection : $selectedMinutes){
                        ForEach(0..<60){ minute in
                            Text("\(minute)")
                                .tag(minute)
                                .font(.title3)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height : 100)
                    .clipped()
                    
                    Text("min")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                .frame(width : WKInterfaceDevice.current().screenBounds.width/2)
                
                VStack {
                    Picker("Seconds" , selection : $selectedSeconds){
                        ForEach(0..<60){second in
                            Text("\(second)").tag(second)
                                .font(.title3)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height : 100)
                    .clipped()
                    
                    Text("sec")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                .frame(width : WKInterfaceDevice.current().screenBounds.width / 2 )
            }
            .padding(.vertical , 5)
            
            Button(action : {
                timeRemaining = ( selectedMinutes * 60 ) + selectedSeconds
                dismiss()
            }){
                Text("Set")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.horizontal , 20)
                    .padding(.vertical , 8)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom , 10)
        }
    }
}

#Preview {
    SetTimeView(timeRemaining: .constant(500))
}
