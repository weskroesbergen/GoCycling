//
//  MainView.swift
//  Go Cycling
//
//  Created by Anthony Hopkins on 2021-03-14.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CycleView()
                .tabItem {
                    Label("Cycle", systemImage: "bicycle")
                }
            
            StatisticsView()
                .tabItem {
                    Label("Statistics", systemImage: "arrow.clockwise.heart")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}