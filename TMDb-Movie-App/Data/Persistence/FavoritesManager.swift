//
//  FavoritesManager.swift
//  TMDb-Movie-App
//

import Foundation

final class FavoritesManager: FavoritesManagerProtocol {

    private let key = "favorite_movie_ids"

    private var favoriteIDs: Set<Int> {
        get {
            let ids = UserDefaults.standard.array(forKey: key) as? [Int] ?? []
            return Set(ids)
        }
        set {
            UserDefaults.standard.set(Array(newValue), forKey: key)
        }
    }

    func addFavorite(_ movieID: Int) {
        favoriteIDs.insert(movieID)
    }

    func removeFavorite(_ movieID: Int) {
        favoriteIDs.remove(movieID)
    }

    func isFavorite(_ movieID: Int) -> Bool {
        favoriteIDs.contains(movieID)
    }

    func allFavoriteIDs() -> [Int] {
        Array(favoriteIDs)
    }
}
