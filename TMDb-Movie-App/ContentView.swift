//
//  ContentView.swift
//  TMDb-Movie-App
//
//  Created by prashanth on 20/02/26.
//

import SwiftUI

struct ContentView: View {

    /// Swap MockMovieDataSource() with APIMovieDataSource() here when ready for live data.
    @StateObject private var session = MovieDataSession(dataSource: MockMovieDataSource())

    var body: some View {
        ZStack {
            Color(hex: "0A0A0F").ignoresSafeArea()

            TabView {
                HomeView()
                    .tabItem { Label("Home", systemImage: "film.stack") }

                SearchView()
                    .tabItem { Label("Search", systemImage: "magnifyingglass") }

                FavoritesView()
                    .tabItem { Label("Favorites", systemImage: "heart.fill") }
            }
            .tint(Color(hex: "E94560"))
        }
        .preferredColorScheme(.dark)
        .environmentObject(session)
        .onAppear { session.loadPopularMovies() }
    }
}

#Preview {
    ContentView()
}
