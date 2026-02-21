//
//  HomeView.swift
//  TMDb-Movie-App
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var session: MovieDataSession
    private let columns = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "0A0A0F").ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    if let featured = session.popularMovies.first {
                        HeroCardView(movie: featured)
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                    }

                    HStack {
                        Text("Popular Right Now")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 4)

                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(session.popularMovies.dropFirst()) { movie in
                            NavigationLink(value: movie) {
                                MoviePosterCard(movie: movie)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 100)
                }
            }
            .navigationTitle("🎬 Movies")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(for: MockMovie.self) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }
}

// MARK: - Hero Card
struct HeroCardView: View {

    let movie: MockMovie
    @EnvironmentObject private var session: MovieDataSession

    var body: some View {
        NavigationLink(value: movie) {
            ZStack(alignment: .bottomLeading) {
                LinearGradient(colors: movie.posterColor, startPoint: .topTrailing, endPoint: .bottomLeading)
                    .frame(height: 260)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(colors: [.clear, Color(hex: "0A0A0F").opacity(0.88)],
                                                 startPoint: .center, endPoint: .bottom))
                    )

                HStack(spacing: 6) {
                    ForEach(0..<5, id: \.self) { _ in
                        Rectangle().fill(.white.opacity(0.05))
                            .frame(width: 28, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(16)

                Text(String(movie.title.prefix(1)))
                    .font(.system(size: 90, weight: .black, design: .rounded))
                    .foregroundStyle(.white.opacity(0.08))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    .padding(.trailing, 20)

                VStack(alignment: .leading, spacing: 6) {
                    Text("FEATURED")
                        .font(.caption2).fontWeight(.bold).kerning(2)
                        .foregroundStyle(movie.accentColor)

                    Text(movie.title)
                        .font(.system(size: 26, weight: .bold)).foregroundStyle(.white)

                    HStack(spacing: 10) {
                        Label(movie.year, systemImage: "calendar")
                        Label(movie.duration, systemImage: "clock")
                        StarRatingView(rating: movie.rating)
                    }
                    .font(.caption).foregroundStyle(.white.opacity(0.7))

                    HStack(spacing: 4) {
                        Label("View Details", systemImage: "info.circle.fill")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.black)
                            .padding(.horizontal, 18).padding(.vertical, 9)
                            .background(movie.accentColor, in: Capsule())

                        Spacer()

                        Button {
                            withAnimation(.spring(duration: 0.3)) { session.toggleFavorite(id: movie.id) }
                        } label: {
                            Image(systemName: session.isFavorite(id: movie.id) ? "heart.fill" : "heart")
                                .font(.system(size: 16))
                                .foregroundStyle(session.isFavorite(id: movie.id) ? Color(hex: "E94560") : .white)
                                .padding(10).background(.white.opacity(0.12), in: Circle())
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.top, 4)
                }
                .padding(20)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Poster Card
struct MoviePosterCard: View {

    let movie: MockMovie
    @EnvironmentObject private var session: MovieDataSession

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                LinearGradient(colors: movie.posterColor, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(RoundedRectangle(cornerRadius: 14).fill(.black.opacity(0.2)))

                Text(String(movie.title.prefix(1)))
                    .font(.system(size: 64, weight: .black, design: .rounded))
                    .foregroundStyle(.white.opacity(0.12))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(.trailing, 8).padding(.bottom, 4)

                Text(movie.genre.components(separatedBy: " · ").first ?? "")
                    .font(.caption2).fontWeight(.bold).foregroundStyle(.white)
                    .padding(.horizontal, 8).padding(.vertical, 4)
                    .background(.ultraThinMaterial, in: Capsule())
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(8)

                Button {
                    withAnimation(.spring(duration: 0.3)) { session.toggleFavorite(id: movie.id) }
                } label: {
                    Image(systemName: session.isFavorite(id: movie.id) ? "heart.fill" : "heart")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(session.isFavorite(id: movie.id) ? Color(hex: "E94560") : .white)
                        .padding(7).background(.black.opacity(0.45), in: Circle())
                        .contentTransition(.symbolEffect(.replace))
                        .animation(.spring(duration: 0.25), value: session.isFavorite(id: movie.id))
                }
                .buttonStyle(.plain)
                .padding(8)
            }

            Text(movie.title)
                .font(.system(size: 13, weight: .semibold)).foregroundStyle(.white).lineLimit(1)

            HStack(spacing: 4) {
                Image(systemName: "star.fill").font(.system(size: 9)).foregroundStyle(.yellow)
                Text(String(format: "%.1f", movie.rating)).font(.system(size: 11)).foregroundStyle(.white.opacity(0.6))
                Spacer()
                Text(movie.year).font(.system(size: 11)).foregroundStyle(.white.opacity(0.4))
            }
        }
    }
}
