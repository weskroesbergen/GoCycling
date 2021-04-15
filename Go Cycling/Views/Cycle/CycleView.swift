//
//  ContentView.swift
//  Go Cycling
//
//  Created by Anthony Hopkins on 2021-03-14.
//

import SwiftUI

struct CycleView: View {
    
    @ObservedObject var timer = TimerViewModel()
    @State private var showingAlert = false
    @State private var isCycling = false
    
    var body: some View {
        VStack {
            MapView(isCycling: $isCycling)
            Spacer()
            Text(formatTimeString(accumulatedTime: timer.totalAccumulatedTime))
                .font(.custom("Avenir", size: 40))
            HStack {
                if (timer.isRunning) {
                    Button (action: {self.timer.pause()}) {
                        TimerButton(label: "Pause", buttonColor: .yellow)
                            .padding(.bottom, 20)
                    }
                    Button (action: {self.confirmStop()}) {
                        TimerButton(label: "Stop", buttonColor: .red)
                            .padding(.bottom, 20)
                    }
                }
                if (timer.isStopped) {
                    Button (action: {self.startCycling()}) {
                        TimerButton(label: "Start", buttonColor: .green)
                            .padding(.bottom, 20)
                    }
                }
                if (timer.isPaused) {
                    Button (action: {self.timer.start()}) {
                        TimerButton(label: "Resume", buttonColor: .green)
                            .padding(.bottom, 20)
                    }
                    Button (action: {self.confirmStop()}) {
                        TimerButton(label: "Stop", buttonColor: .red)
                            .padding(.bottom, 20)
                    }
                }
            }
        }
        
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Are you sure that you want to end the current bike ride?"),
                  message: Text("Please confirm that you are ready to end the current bike ride."),
                  primaryButton: .destructive(Text("Stop")) {
                    self.timer.stop()
                    self.isCycling = false
                  },
                  secondaryButton: .cancel()
            )
        }
    }
    
    func formatTimeString(accumulatedTime: TimeInterval) -> String {
        let hours = Int(accumulatedTime) / 3600
        let minutes = Int(accumulatedTime) / 60 % 60
        let seconds = Int(accumulatedTime) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func startCycling() {
        self.isCycling = true
        self.timer.start()
    }
    
    func confirmStop() {
        self.timer.pause()
        showingAlert = true
    }
}

struct CycleView_Previews: PreviewProvider {
    static var previews: some View {
        CycleView()
    }
}