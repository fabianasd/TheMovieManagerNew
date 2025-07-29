import Foundation

@MainActor
class MovieStore: ObservableObject {
    static let shared = MovieStore()

    @Published var watchlist: [Movie] = []
    @Published var favorites: [Movie] = []

    private init() {}

    func isFavorite(_ movie: Movie) -> Bool {
        return favorites.contains(movie)
    }

    func isInWatchlist(_ movie: Movie) -> Bool {
        return watchlist.contains(movie)
    }

    func toggleFavorite(_ movie: Movie) {
        if isFavorite(movie) {
            favorites.removeAll { $0 == movie }
        } else {
            favorites.append(movie)
        }
    }
    
    func getFavorites() -> [Movie] {
        return favorites
    }

    func toggleWatchlist(_ movie: Movie) {
        if isInWatchlist(movie) {
            watchlist.removeAll { $0 == movie }
        } else {
            watchlist.append(movie)
        }
    }
    
    func getWatchlist() -> [Movie] {
        return watchlist
    }
}
