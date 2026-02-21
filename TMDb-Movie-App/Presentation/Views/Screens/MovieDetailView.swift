//
//  MovieDetailView.swift
//  TMDb-Movie-App
//

import SwiftUI

struct MovieDetailView: View {

    let movie: MockMovie
    @EnvironmentObject private var session: MovieDataSession
    @State private var showTrailerPlayer = false

    var body: some View {
        ZStack {
            Color(hex: "0A0A0F").ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    heroSection
                    if showTrailerPlayer { trailerSection }
                    contentSection
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .animation(.spring(duration: 0.4), value: showTrailerPlayer)
    }

    // MARK: - Hero
    private var heroSection: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(colors: movie.posterColor, startPoint: .topTrailing, endPoint: .bottomLeading)
                .frame(height: 340)

            Text(String(movie.title.prefix(1)))
                .font(.system(size: 180, weight: .black, design: .rounded))
                .foregroundStyle(.white.opacity(0.07))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .padding(.trailing, 10)

            LinearGradient(colors: [.clear, Color(hex: "0A0A0F")], startPoint: .top, endPoint: .bottom)
                .frame(height: 160)

            Button { withAnimation { showTrailerPlayer.toggle() } } label: {
                HStack(spacing: 8) {
                    Image(systemName: showTrailerPlayer ? "stop.fill" : "play.fill")
                    Text(showTrailerPlayer ? "Hide Trailer" : "Play Trailer").fontWeight(.bold)
                }
                .font(.system(size: 14)).foregroundStyle(.white)
                .padding(.horizontal, 24).padding(.vertical, 12)
                .background(movie.accentColor.gradient, in: Capsule())
                .shadow(color: movie.accentColor.opacity(0.6), radius: 10, x: 0, y: 4)
            }
            .padding(.bottom, 24)
        }
    }

    // MARK: - Trailer
    private var trailerSection: some View {
        ZStack {
            Color.black
            VStack(spacing: 12) {
                Image(systemName: "play.rectangle.fill").font(.system(size: 52)).foregroundStyle(movie.accentColor)
                Text("Trailer Player").font(.headline).foregroundStyle(.white)
                Text("YouTube WKWebView attaches here").font(.caption).foregroundStyle(.white.opacity(0.4))
            }
        }
        .frame(height: 210)
        .transition(.move(edge: .top).combined(with: .opacity))
    }

    // MARK: - Content
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: 20) {

            // Title + Favorite
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title).font(.system(size: 26, weight: .bold)).foregroundStyle(.white)
                    Text(movie.genre).font(.subheadline).foregroundStyle(movie.accentColor)
                }
                Spacer()
                Button {
                    withAnimation(.spring(duration: 0.3)) { session.toggleFavorite(id: movie.id) }
                } label: {
                    Image(systemName: session.isFavorite(id: movie.id) ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundStyle(session.isFavorite(id: movie.id) ? Color(hex: "E94560") : .white.opacity(0.5))
                        .padding(12).background(Color(hex: "1C1C28"), in: Circle())
                        .contentTransition(.symbolEffect(.replace))
                        .animation(.spring(duration: 0.3), value: session.isFavorite(id: movie.id))
                }
            }

            // Stat chips
            HStack(spacing: 8) {
                InfoChipView(icon: "star.fill", text: String(format: "%.1f / 10", movie.rating), color: .yellow)
                InfoChipView(icon: "clock", text: movie.duration, color: .white.opacity(0.7))
                InfoChipView(icon: "calendar", text: movie.year, color: .white.opacity(0.7))
            }

            Divider().background(.white.opacity(0.08))

            // Overview
            VStack(alignment: .leading, spacing: 8) {
                Text("Overview").font(.system(size: 17, weight: .semibold)).foregroundStyle(.white)
                Text(movie.overview).font(.system(size: 14)).foregroundStyle(.white.opacity(0.65))
                    .lineSpacing(5).fixedSize(horizontal: false, vertical: true)
            }

            Divider().background(.white.opacity(0.08))

            // Cast
            VStack(alignment: .leading, spacing: 12) {
                Text("Cast").font(.system(size: 17, weight: .semibold)).foregroundStyle(.white)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(Array(movie.castNames.enumerated()), id: \.offset) { _, name in
                            CastBubbleView(name: name, color: movie.accentColor)
                        }
                    }
                }
            }

            Spacer(minLength: 40)
        }
        .padding(.horizontal, 20).padding(.top, 20)
    }
}

// MARK: - Cast Bubble
struct CastBubbleView: View {
    let name: String
    let color: Color
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle().fill(color.opacity(0.18)).frame(width: 60, height: 60)
                Text(String(name.prefix(1))).font(.system(size: 24, weight: .bold, design: .rounded)).foregroundStyle(color)
            }
            Text(name.components(separatedBy: " ").first ?? name)
                .font(.caption2).foregroundStyle(.white.opacity(0.7))
        }
        .frame(width: 70)
    }
}
