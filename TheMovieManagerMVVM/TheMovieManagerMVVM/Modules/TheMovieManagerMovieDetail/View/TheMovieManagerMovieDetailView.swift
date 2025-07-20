import SwiftUI

struct TheMovieManagerMovieDetailView: View {
    @ObservedObject var viewModel: TheMovieManagerMovieDetailViewModel

    var body: some View {
        VStack {
            Group {
                if let data = viewModel.posterData,
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Color.gray
                        .frame(height: 300)
                        .overlay(Text("No Image").foregroundColor(.white))
                }
            }

            Text(viewModel.movie.title)
                .font(.title)

            HStack {
                Button(action: {
                    viewModel.toggleWatchlist()
                }) {
                    Label(viewModel.isWatchlist ? "Remove Watchlist" : "Add to Watchlist", systemImage: "eye")
                }

                Button(action: {
                    viewModel.toggleFavorite()
                }) {
                    Label(viewModel.isFavorite ? "Unfavorite" : "Favorite", systemImage: "heart")
                }
            }

            Spacer()
        }
    }
}

#if DEBUG
struct TheMovieManagerMovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMovie = Movie(
            posterPath: nil,
            adult: false,
            overview: "A mind-bending thriller where dreams become reality.",
            releaseDate: "2010-07-16",
            genreIds: [28, 878, 12],
            id: 1,
            originalTitle: "Inception",
            originalLanguage: "en",
            title: "Inception",
            backdropPath: nil,
            popularity: 98.5,
            voteCount: 22000,
            video: false,
            voteAverage: 8.8
        )

        let viewModel = TheMovieManagerMovieDetailViewModel(movie: mockMovie)
        return TheMovieManagerMovieDetailView(viewModel: viewModel)
            .previewDevice("iPhone 14")
    }
}
#endif


