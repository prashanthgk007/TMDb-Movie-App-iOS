//
//  MockMovieDataSource.swift
//  TMDb-Movie-App
//

import SwiftUI

final class MockMovieDataSource: MovieDataSourceProtocol {

    func fetchPopularMovies() -> [MockMovie] { MockMovie.sampleData }

    func searchMovies(query: String) -> [MockMovie] {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return [] }
        return MockMovie.sampleData.filter {
            $0.title.localizedCaseInsensitiveContains(query) ||
            $0.genre.localizedCaseInsensitiveContains(query)
        }
    }
}

// MARK: - Sample Data
extension MockMovie {
    static let sampleData: [MockMovie] = [
        MockMovie(id: 1, title: "Dune: Part Two", genre: "Sci-Fi · Adventure",
                  rating: 8.4, year: "2024", duration: "2h 46m",
                  overview: "Paul Atreides unites with Chani and the Fremen while on a warpath of revenge against the conspirators who destroyed his family.",
                  posterColor: [Color(hex: "C8860A"), Color(hex: "6B3A00")], accentColor: Color(hex: "C8860A"),
                  castNames: ["Timothée Chalamet", "Zendaya", "Rebecca Ferguson", "Josh Brolin", "Austin Butler"]),

        MockMovie(id: 2, title: "Oppenheimer", genre: "Drama · History",
                  rating: 8.9, year: "2023", duration: "3h 0m",
                  overview: "The story of J. Robert Oppenheimer's role in the development of the atomic bomb during World War II.",
                  posterColor: [Color(hex: "B22222"), Color(hex: "1A0000")], accentColor: Color(hex: "FF4444"),
                  castNames: ["Cillian Murphy", "Emily Blunt", "Matt Damon", "Robert Downey Jr.", "Florence Pugh"]),

        MockMovie(id: 3, title: "Poor Things", genre: "Comedy · Drama",
                  rating: 8.0, year: "2023", duration: "2h 21m",
                  overview: "The incredible tale about the fantastical evolution of Bella Baxter, a young woman brought back to life by an unorthodox scientist.",
                  posterColor: [Color(hex: "6A0DAD"), Color(hex: "200037")], accentColor: Color(hex: "B060FF"),
                  castNames: ["Emma Stone", "Mark Ruffalo", "Willem Dafoe", "Ramy Youssef"]),

        MockMovie(id: 4, title: "Killers of the Flower Moon", genre: "Crime · Drama",
                  rating: 7.7, year: "2023", duration: "3h 26m",
                  overview: "Members of the Osage Nation are murdered under mysterious circumstances in the 1920s, sparking a major FBI investigation.",
                  posterColor: [Color(hex: "8B4513"), Color(hex: "1A0A00")], accentColor: Color(hex: "D2691E"),
                  castNames: ["Leonardo DiCaprio", "Robert De Niro", "Lily Gladstone"]),

        MockMovie(id: 5, title: "Furiosa", genre: "Action · Adventure",
                  rating: 7.9, year: "2024", duration: "2h 28m",
                  overview: "The origin story of Furiosa before she teamed up with Mad Max, depicting her quest for home.",
                  posterColor: [Color(hex: "CC4400"), Color(hex: "1A0500")], accentColor: Color(hex: "FF6600"),
                  castNames: ["Anya Taylor-Joy", "Chris Hemsworth", "Tom Burke"]),

        MockMovie(id: 6, title: "Inside Out 2", genre: "Animation · Family",
                  rating: 7.8, year: "2024", duration: "1h 40m",
                  overview: "Riley enters adolescence and her Headquarters experiences a sudden disruption when new Emotions arrive.",
                  posterColor: [Color(hex: "FF9500"), Color(hex: "FF3B9A")], accentColor: Color(hex: "FF9500"),
                  castNames: ["Amy Poehler", "Maya Hawke", "Kensington Tallman"]),

        MockMovie(id: 7, title: "Deadpool & Wolverine", genre: "Action · Comedy",
                  rating: 7.8, year: "2024", duration: "2h 7m",
                  overview: "Deadpool is thrust into the Marvel Cinematic Universe and teams up with a reluctant Wolverine.",
                  posterColor: [Color(hex: "CC0000"), Color(hex: "300000")], accentColor: Color(hex: "FF2020"),
                  castNames: ["Ryan Reynolds", "Hugh Jackman", "Emma Corrin"]),

        MockMovie(id: 8, title: "Alien: Romulus", genre: "Horror · Sci-Fi",
                  rating: 7.4, year: "2024", duration: "1h 59m",
                  overview: "Young colonists face the most terrifying life form in the universe while exploring an abandoned space station.",
                  posterColor: [Color(hex: "00AA44"), Color(hex: "001A0B")], accentColor: Color(hex: "00FF66"),
                  castNames: ["Cailee Spaeny", "David Jonsson", "Archie Renaux"]),

        MockMovie(id: 9, title: "Civil War", genre: "Action · Drama",
                  rating: 7.3, year: "2024", duration: "1h 49m",
                  overview: "A team of journalists travel across a dystopian future America during a civil war.",
                  posterColor: [Color(hex: "445566"), Color(hex: "0A0F14")], accentColor: Color(hex: "6699CC"),
                  castNames: ["Kirsten Dunst", "Wagner Moura", "Cailee Spaeny"]),

        MockMovie(id: 10, title: "The Substance", genre: "Horror · Sci-Fi",
                  rating: 7.3, year: "2024", duration: "2h 21m",
                  overview: "A fading celebrity uses a black-market drug to generate a younger, better version of herself.",
                  posterColor: [Color(hex: "CC0066"), Color(hex: "1A0010")], accentColor: Color(hex: "FF3399"),
                  castNames: ["Demi Moore", "Margaret Qualley", "Dennis Quaid"]),

        MockMovie(id: 11, title: "Twisters", genre: "Action · Adventure",
                  rating: 7.2, year: "2024", duration: "2h 2m",
                  overview: "Storm chasers test their chasing skills in the most extreme weather conditions ever seen.",
                  posterColor: [Color(hex: "1155AA"), Color(hex: "040C1A")], accentColor: Color(hex: "3388FF"),
                  castNames: ["Daisy Edgar-Jones", "Glen Powell", "Anthony Ramos"]),

        MockMovie(id: 12, title: "Longlegs", genre: "Horror · Thriller",
                  rating: 6.4, year: "2024", duration: "1h 41m",
                  overview: "An FBI agent works to decode the complex letters of a serial killer.",
                  posterColor: [Color(hex: "222244"), Color(hex: "05050F")], accentColor: Color(hex: "9988FF"),
                  castNames: ["Maika Monroe", "Nicolas Cage", "Blair Underwood"])
    ]
}
