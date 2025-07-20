import Foundation

extension Movie {
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return TMDBClient.Endpoints.posterImage(path).url
    }
}
