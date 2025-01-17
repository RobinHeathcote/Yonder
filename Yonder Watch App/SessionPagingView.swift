//
//  SessionPagingView.swift
//  Yonder
//
//  Created by Robin Heathcote on 17/01/2025.
//


import SwiftUI
import WatchKit

struct SessionPagingView: View {
    @State private var selection: Tab = .metrics
    enum Tab {
        case controls, metrics, nowPlaying
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ControlsView().tag(Tab.controls)
            MetricsView().tag(Tab.metrics)
            NowPlayingView().tag(Tab.nowPlaying)
        }
    }
}
#Preview {
    SessionPagingView()
}
