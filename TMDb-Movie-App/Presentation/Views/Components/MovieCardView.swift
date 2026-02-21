//
//  MovieCardView.swift
//  TMDb-Movie-App
//

import SwiftUI

struct MovieCardView: View {

    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .overlay { ProgressView() }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(movie.title)
                .font(.subheadline).bold()
                .lineLimit(2)
                .foregroundStyle(.primary)

            RatingView(rating: movie.voteAverage)
        }
    }
}
