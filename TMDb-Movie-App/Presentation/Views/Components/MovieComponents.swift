//
//  MovieComponents.swift
//  TMDb-Movie-App
//

import SwiftUI

/// Small star + numeric rating badge
struct StarRatingView: View {
    let rating: Double

    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "star.fill")
                .font(.system(size: 9))
                .foregroundStyle(.yellow)
            Text(String(format: "%.1f", rating))
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
        }
    }
}

/// Pill-shaped info chip with icon + text
struct InfoChipView: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .font(.system(size: 10))
                .foregroundStyle(color)
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(color)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color(hex: "1C1C28"), in: Capsule())
    }
}
