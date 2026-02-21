//
//  SearchView.swift
//  TMDb-Movie-App
//

import SwiftUI

struct SearchView: View {

    @EnvironmentObject private var session: MovieDataSession
    @State private var query = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "0A0A0F").ignoresSafeArea()

                VStack(spacing: 0) {
                    // Search bar
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass").foregroundStyle(.white.opacity(0.4))
                        TextField("", text: $query,
                                  prompt: Text("Search movies, genres…").foregroundStyle(.white.opacity(0.35)))
                            .foregroundStyle(.white)
                            .autocorrectionDisabled()
                            .onChange(of: query) { _, newValue in
                                if newValue.isEmpty { session.clearSearch() }
                                else { session.search(query: newValue) }
                            }
                        if !query.isEmpty {
                            Button { query = ""; session.clearSearch() } label: {
                                Image(systemName: "xmark.circle.fill").foregroundStyle(.white.opacity(0.4))
                            }
                        }
                    }
                    .padding(14)
                    .background(Color(hex: "1C1C28"), in: RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal, 16).padding(.vertical, 12)

                    if query.isEmpty {
                        idleState
                    } else if session.searchResults.isEmpty {
                        noResultsState
                    } else {
                        resultsList
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(for: MockMovie.self) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }

    private var idleState: some View {
        VStack(spacing: 14) {
            Spacer()
            Image(systemName: "film.stack").font(.system(size: 54))
                .foregroundStyle(Color(hex: "E94560").opacity(0.6))
            Text("Find your next watch").font(.headline).foregroundStyle(.white)
            Text("Search by title or genre").font(.subheadline).foregroundStyle(.white.opacity(0.4))
            Spacer()
        }
    }

    private var noResultsState: some View {
        VStack(spacing: 14) {
            Spacer()
            Image(systemName: "magnifyingglass").font(.system(size: 44)).foregroundStyle(.white.opacity(0.2))
            Text("No results for \"\(query)\"").font(.headline).foregroundStyle(.white.opacity(0.5))
            Spacer()
        }
    }

    private var resultsList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(session.searchResults) { movie in
                    NavigationLink(value: movie) {
                        SearchResultRow(movie: movie)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16).padding(.bottom, 100)
        }
    }
}

// MARK: - Search Result Row
struct SearchResultRow: View {

    let movie: MockMovie
    @EnvironmentObject private var session: MovieDataSession

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                LinearGradient(colors: movie.posterColor, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 62, height: 88).clipShape(RoundedRectangle(cornerRadius: 10))
                Text(String(movie.title.prefix(1)))
                    .font(.system(size: 30, weight: .black, design: .rounded))
                    .foregroundStyle(.white.opacity(0.25))
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title).font(.system(size: 15, weight: .semibold)).foregroundStyle(.white).lineLimit(1)
                Text(movie.genre).font(.caption).foregroundStyle(movie.accentColor)
                HStack(spacing: 6) {
                    StarRatingView(rating: movie.rating)
                    Text("·").foregroundStyle(.white.opacity(0.3))
                    Text(movie.duration).font(.caption).foregroundStyle(.white.opacity(0.5))
                }
            }

            Spacer()

            Button {
                withAnimation(.spring(duration: 0.3)) { session.toggleFavorite(id: movie.id) }
            } label: {
                Image(systemName: session.isFavorite(id: movie.id) ? "heart.fill" : "heart")
                    .font(.system(size: 18))
                    .foregroundStyle(session.isFavorite(id: movie.id) ? Color(hex: "E94560") : .white.opacity(0.35))
                    .contentTransition(.symbolEffect(.replace))
                    .animation(.spring(duration: 0.25), value: session.isFavorite(id: movie.id))
            }
            .buttonStyle(.plain)
        }
        .padding(12)
        .background(Color(hex: "1C1C28"), in: RoundedRectangle(cornerRadius: 14))
    }
}
