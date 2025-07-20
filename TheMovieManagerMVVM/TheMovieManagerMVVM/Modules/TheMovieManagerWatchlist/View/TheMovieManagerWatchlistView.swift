import SwiftUI

struct TheMovieManagerWatchlistView: View {
    @ObservedObject var viewModel: TheMovieManagerWatchlistViewModel

    var body: some View {
        NavigationView {
            List(viewModel.movies.indices, id: \.self) { index in
                let movie = viewModel.movies[index]
                NavigationLink(destination: Text("Detalhes de \\(movie.title)")) {
                    HStack {
                        AsyncImage(url: movie.posterURL) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 50, height: 75)
                        .cornerRadius(4)

                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text(movie.releaseYear)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Watchlist")
            .onAppear {
                viewModel.loadWatchlist()
            }
        }
    }
}

#if DEBUG
struct TheMovieManagerWatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        TheMovieManagerWatchlistView(viewModel: TheMovieManagerWatchlistViewModel())
            .previewDevice("iPhone 14")
    }
}
#endif
