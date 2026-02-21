//
//  RatingView.swift
//  TMDb-Movie-App
//

import SwiftUI

struct RatingView: View {

    let rating: Double

    /// Rating is out of 10; display as stars out of 5.
    private var stars: Double { rating / 2 }

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: starName(for: index))
                    .foregroundStyle(.yellow)
                    .font(.caption)
            }
            Text(String(format: "%.1f", rating))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func starName(for index: Int) -> String {
        if Double(index) <= stars {
            return "star.fill"
        } else if Double(index) - stars < 1 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}

#Preview {
    RatingView(rating: 7.4)
}
