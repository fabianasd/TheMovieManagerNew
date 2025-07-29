import Foundation

@MainActor
class TheMovieManagerMovieDetailViewModel: ObservableObject {
    @Published var isFavorite: Bool
    @Published var isWatchlist: Bool
    @Published var posterData: Data? = nil
    @Published var errorMessage: String?
    
    private let movie: Movie
    private var store = MovieStore.shared
    
    init(movie: Movie, store: MovieStore) {
        self.movie = movie
        self.store = store
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
                errorMessage = "Erro ao carregar imagem: \(error)"
            }
        }
    }
    
    func toggleFavorite() {
        Task {
            do {
                let success = try await TMDBClient.markFavorite(
                    movieId: movie.id,
                    favorite: !isFavorite
                )
                if success {
                    isFavorite.toggle()
                    store.toggleFavorite(movie)
                } else {
                    errorMessage = "Não foi possível marcar como favorito."
                }
            } catch {
                errorMessage = "Erro ao favoritar: \(error.localizedDescription)"
            }
        }
    }

    
    
    func toggleWatchlist() {
        Task {
            do {
                let success = try await TMDBClient.markWatchlist(
                    movieId: movie.id,
                    watchlist: !isWatchlist
                )
                if success {
                    isWatchlist.toggle()
                    store.toggleWatchlist(movie)
                } else {
                    errorMessage = "Não foi possível adicionar à lista de desejos."
                }
            } catch {
                errorMessage = "Erro ao adicionar à watchlist: \(error.localizedDescription)"
            }
        }
    }
}
