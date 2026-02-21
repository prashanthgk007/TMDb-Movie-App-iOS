//
//  FavoritesManagerProtocol.swift
//  TMDb-Movie-App
//

import Foundation

protocol FavoritesManagerProtocol {
    func addFavorite(_ movieID: Int)
    func removeFavorite(_ movieID: Int)
    func isFavorite(_ movieID: Int) -> Bool
    func allFavoriteIDs() -> [Int]
}
