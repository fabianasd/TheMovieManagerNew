import SwiftUI

struct TheMovieManagerSearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search movies...", text: $viewModel.query)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .onChange(of: viewModel.query) { _ in
                        viewModel.searchMovies()
                    }

                List(viewModel.movies.indices, id: \.self) { index in
                    let movie = viewModel.movies[index]
                    NavigationLink(destination: Text("Detalhes de \(movie.title)")) {
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
            .navigationTitle("Search")
        }
    }
}

#if DEBUG
struct TheMovieManagerSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TheMovieManagerSearchView(viewModel: SearchViewModel())
            .previewDevice("iPhone 14")
    }
}
#endif
