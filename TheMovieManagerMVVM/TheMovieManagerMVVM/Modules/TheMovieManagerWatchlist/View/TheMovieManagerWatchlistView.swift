import SwiftUI

struct TheMovieManagerWatchlistView: View {
    @ObservedObject var viewModel: TheMovieManagerWatchlistViewModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if viewModel.movies.isEmpty {
                VStack {
                    Spacer()
                    Text("Nenhum filme salvo encontrado.")
                        .foregroundColor(.gray)
                        .font(.body)
                        .padding()
                    Spacer()
                }
            } else {
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
            }
        }
        .navigationTitle("Salvos")
        .foregroundColor(.gray)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            viewModel.loadWatchlist()
        }
    }
}

#if DEBUG
struct TheMovieManagerWatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TheMovieManagerWatchlistView(viewModel: TheMovieManagerWatchlistViewModel())
        }
        .previewDevice("iPhone 14")
    }
}
#endif
