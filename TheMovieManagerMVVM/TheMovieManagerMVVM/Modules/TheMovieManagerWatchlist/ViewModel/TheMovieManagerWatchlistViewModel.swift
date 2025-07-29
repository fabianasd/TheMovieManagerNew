import Foundation

@MainActor
class TheMovieManagerWatchlistViewModel: ObservableObject {
    @Published var movies: [Movie] = []

    private let store = MovieStore.shared

    func loadWatchlist() {
        movies = store.getWatchlist()
    }

    func isInWatchlist(_ movie: Movie) -> Bool {
        return store.isInWatchlist(movie)
    }

    func selectMovie(at index: Int) -> Movie {
        return movies[index]
    }
}
