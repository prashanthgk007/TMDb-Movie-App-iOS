//
//  FavoritesView.swift
//  TMDb-Movie-App
//

import SwiftUI

struct FavoritesView: View {

    @EnvironmentObject private var session: MovieDataSession
    private let columns = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "0A0A0F").ignoresSafeArea()

                if session.favoriteMovies.isEmpty {
                    emptyState
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 14) {
                            ForEach(session.favoriteMovies) { movie in
                                NavigationLink(value: movie) {
                                    MoviePosterCard(movie: movie)
                                }
                                .buttonStyle(.plain)
                                .transition(.asymmetric(
                                    insertion: .scale.combined(with: .opacity),
                                    removal: .scale.combined(with: .opacity)
                                ))
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 100)
                        .animation(.spring(duration: 0.4), value: session.favorites)
                    }
                }
            }
            .navigationTitle("❤️ Favorites")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(for: MockMovie.self) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.slash.fill")
                .font(.system(size: 56)).foregroundStyle(Color(hex: "E94560").opacity(0.4))
            Text("No Favorites Yet").font(.headline).foregroundStyle(.white)
            Text("Tap ♥ on any movie to save it here.")
                .font(.subheadline).foregroundStyle(.white.opacity(0.4))
        }
        .padding()
    }
}
