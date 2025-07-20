import Foundation

@MainActor
class TheMovieManagerWatchlistViewModel: ObservableObject {
    @Published var movies: [Movie] = []

    func loadWatchlist() {
        Task {
            do {
                let result = try await TMDBClient.getWatchlist()
                self.movies = result
            } catch {
                print("Erro ao carregar a watchlist: \\(error)")
                self.movies = []
            }
        }
    }

    func selectMovie(at index: Int) -> Movie {
        return movies[index]
    }
}
