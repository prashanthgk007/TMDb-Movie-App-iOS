//
//  FavoriteButton.swift
//  TMDb-Movie-App
//

import SwiftUI

struct FavoriteButton: View {

    let isFavorite: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.title2)
                .foregroundStyle(isFavorite ? .red : .gray)
                .contentTransition(.symbolEffect(.replace))
                .animation(.spring(duration: 0.3), value: isFavorite)
        }
        .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
    }
}

#Preview {
    FavoriteButton(isFavorite: true, action: {})
}
