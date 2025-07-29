import SwiftUI

struct TheMovieManagerFavoritesView: View {
    @ObservedObject var viewModel: TheMovieManagerFavoritesViewModel

    var body: some View {
        List(viewModel.movies.indices, id: \.self) { index in
            let movie = viewModel.movies[index]
            NavigationLink(destination: TheMovieManagerMovieDetailView(viewModel: TheMovieManagerMovieDetailViewModel(movie: movie))) {
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
                            .foregroundColor(.white)
                        Text(movie.releaseYear)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .listRowBackground(Color.gray.opacity(0.2))
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Favoritos")
        .foregroundColor(.gray)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}

#if DEBUG
struct TheMovieManagerFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TheMovieManagerFavoritesView(viewModel: TheMovieManagerFavoritesViewModel())
        }
        .previewDevice("iPhone 14")
    }
}
#endif
