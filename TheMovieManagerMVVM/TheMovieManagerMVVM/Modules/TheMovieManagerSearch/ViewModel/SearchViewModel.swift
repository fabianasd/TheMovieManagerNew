import Foundation

@MainActor
public class SearchViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var query: String = ""
    @Published var isLoading = false

    private var currentTask: Task<Void, Never>? = nil

    func searchMovies() {
        currentTask?.cancel()

        let searchText = query.trimmingCharacters(in: .whitespaces)
        guard !searchText.isEmpty else {
            self.movies = []
            self.isLoading = false
            return
        }

        isLoading = true

        currentTask = Task {
            do {
                let result = try await TMDBClient.search(query: searchText)
                self.movies = result
            } catch {
                print("Erro ao buscar filmes: \(error)")
                self.movies = []
            }

            self.isLoading = false
        }
    }

    func selectMovie(at index: Int) -> Movie {
        return movies[index]
    }
}
