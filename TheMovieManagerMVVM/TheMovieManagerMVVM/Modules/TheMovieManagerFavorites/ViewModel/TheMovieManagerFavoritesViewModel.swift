import Foundation

@MainActor
class TheMovieManagerFavoritesViewModel: ObservableObject {
    @Published var movies: [Movie] = []

    func loadFavorites() {
        Task {
            do {
                let result = try await TMDBClient.getFavorites()
                self.movies = result
            } catch {
                self.movies = []
            }
        }
    }

    func selectMovie(at index: Int) -> Movie {
        return movies[index]
    }
}
