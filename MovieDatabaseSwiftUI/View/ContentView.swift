//
//  ContentView.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 17/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label(Constants.homeString, systemImage: Constants.homeIconString)
                    }
                    .toolbar(.visible, for: .tabBar)
                
                SearchView()
                    .tabItem {
                        Label(Constants.searchString, systemImage: Constants.searchIconString)
                    }
                    .toolbar(.visible, for: .tabBar)
                
                LikedMoviesView()
                    .tabItem {
                        Label(Constants.likedString, systemImage: Constants.likedIconString)
                    }
                    .toolbar(.visible, for: .tabBar)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}
