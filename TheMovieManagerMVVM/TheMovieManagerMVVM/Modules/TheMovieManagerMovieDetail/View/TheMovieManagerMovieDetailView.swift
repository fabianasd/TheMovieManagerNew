import SwiftUI

struct TheMovieManagerMovieDetailView: View {
    @StateObject var viewModel: TheMovieManagerMovieDetailViewModel
    
    init(movie: Movie, store: MovieStore) {
        _viewModel = StateObject(wrappedValue: TheMovieManagerMovieDetailViewModel(movie: movie, store: store))
    }
    
    var body: some View {
        VStack {
            Spacer()
            Group {
                if let data = viewModel.posterData,
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Color.gray
                        .frame(height: 300)
                        .overlay(Text("Sem imagem").foregroundColor(.white))
                }
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button(action: {
                    viewModel.toggleWatchlist()
                }) {
                    Label(viewModel.isWatchlist ? "Remover da lista" : "Adicionar a lista",
                          systemImage: viewModel.isWatchlist ? "eye.fill" : "eye")
                    .foregroundColor(Color.white)
                }
                
                Button(action: {
                    viewModel.toggleFavorite()
                }) {
                    Label(viewModel.isFavorite ? "Desmarcar" : "Favorito",
                          systemImage: viewModel.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(Color.white)
                }
            }
            .padding(.bottom, 16)
        }
        .alert("Atenção", isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Button("OK", role: .cancel) { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .padding(.horizontal)
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Filme selecionado")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#if DEBUG
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMovie = Movie(
            posterPath: nil,
            adult: false,
            overview: "A mind‑bending thriller where dreams become reality.",
            releaseDate: "2010-07-16",
            genreIds: [28, 878, 12],
            id: 1,
            originalTitle: "Inception",
            originalLanguage: "en",
            title: "Inception",
            backdropPath: nil,
            popularity: 98.5,
            voteCount: 22_000,
            video: false,
            voteAverage: 8.8
        )
        let store = MovieStore.shared
        let viewModel = TheMovieManagerMovieDetailViewModel(movie: mockMovie, store: store)
        return TheMovieManagerMovieDetailView(movie: mockMovie, store: store)
            .previewDevice("iPhone 14")
    }
}
#endif
