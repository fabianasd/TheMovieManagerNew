import Foundation

@MainActor
class TheMovieManagerMovieDetailViewModel: ObservableObject {
    @Published var isFavorite: Bool
    @Published var isWatchlist: Bool
    @Published var posterData: Data? = nil

    let movie: Movie
    private let store = MovieStore.shared

    init(movie: Movie) {
        self.movie = movie
        self.isFavorite = store.isFavorite(movie)
        self.isWatchlist = store.isInWatchlist(movie)
        loadPoster()
    }

    func loadPoster() {
        guard let path = movie.posterPath else { return }
        Task {
            do {
                if let data = try await TMDBClient.downloadPosterImage(path: path) {
                    self.posterData = data
                }
            } catch {
                print("Erro ao carregar imagem: \(error)")
            }
        }
    }

    func toggleFavorite() {
        Task {
            let success = try await TMDBClient.markFavorite(movieId: movie.id, favorite: !isFavorite)
            if success {
                store.toggleFavorite(movie)
                isFavorite = store.isFavorite(movie)
            }
        }
    }

    func toggleWatchlist() {
        Task {
            let success = try await TMDBClient.markWatchlist(movieId: movie.id, watchlist: !isWatchlist)
            if success {
                store.toggleWatchlist(movie)
                isWatchlist = store.isInWatchlist(movie)
            }
        }
    }
}
