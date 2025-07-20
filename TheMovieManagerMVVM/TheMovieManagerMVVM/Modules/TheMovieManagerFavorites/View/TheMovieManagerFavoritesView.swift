import SwiftUI

struct TheMovieManagerFavoritesView: View {
    @ObservedObject var viewModel: TheMovieManagerFavoritesViewModel

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
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.loadFavorites()
            }
        }
    }
}

#if DEBUG
struct TheMovieManagerFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        TheMovieManagerFavoritesView(viewModel: TheMovieManagerFavoritesViewModel())
            .previewDevice("iPhone 14")
    }
}
#endif
