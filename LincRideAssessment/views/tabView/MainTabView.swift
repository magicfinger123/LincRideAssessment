//
//  MainTabView.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 06/08/2025.
//


import SwiftUI


enum Tab {
    case map
    case favorites
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .map

    var body: some View {
        ZStack {
            // Your main views
            Group {
                switch selectedTab {
                case .map:
                    MainMapView()
                case .favorites:
                    SavedPlacesView()
                }
            }
            .edgesIgnoringSafeArea(.all)

            // Custom tab bar
            VStack {
                Spacer()
                HStack {
                    TabBarButton(tab: .map, selectedTab: $selectedTab, icon: "map", title: "Map")
                    TabBarButton(tab: .favorites, selectedTab: $selectedTab, icon: "star.fill", title: "Favorites")
                }
                .background(Color(.systemBackground).opacity(0.95))
                .clipShape(Capsule())
                .shadow(radius: 5)
                .padding(.horizontal, 80)
                .padding(.bottom, 20)
            }
        }
    }
}
struct TabBarButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    let icon: String
    let title: String

    var body: some View {
        Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(selectedTab == tab ? .blue : .gray)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
        }
    }
}
