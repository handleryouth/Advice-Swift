//
//  ContentView.swift
//  Advice Swift
//
//  Created by Tony Gultom on 19/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var activeTab = 0
    
   
    init() {
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            navigationBarAppearance.backgroundColor = UIColor.grayishBlue
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor.grayishBlue
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
       }
    
    var body: some View {
        TabView(selection: $activeTab) {
            SearchView().tabItem{
                Label("Search Advice", systemImage: "magnifyingglass")
            }.tag(0)
            
            RandomView().tabItem{
                Label("Random Advice", systemImage: "dice.fill")
            }.tag(1)
        }.tint(Color.white)
    }
}
