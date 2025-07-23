import SwiftUI

public struct TheMovieManagerSearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State private var isEditing = false
    
    public var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Pesquisar")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(.top)
                        .padding(.horizontal, 16)
                    
                    TextField("", text: $viewModel.query, prompt: Text("Digite o nome do filme").foregroundColor(.white.opacity(0.2)))
                        .padding(10)
                        .background(Color(white: 0.2))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                        .onChange(of: viewModel.query) { _ in
                            viewModel.searchMovies()
                        }
                    
                    Spacer(minLength: 30)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .foregroundColor(.white)
                            .padding()
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: .infinity,
                                alignment: .center
                            )
                    } else if !viewModel.movies.isEmpty {
                        List {
                            ForEach(viewModel.movies.indices, id: \.self) { index in
                                let movie = viewModel.movies[index]
                                NavigationLink(
                                    destination: TheMovieManagerMovieDetailView(
                                        viewModel: TheMovieManagerMovieDetailViewModel(movie: movie)
                                    )
                                ) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(movie.title)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(movie.releaseYear)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.vertical, 4)
                                }
                                .listRowBackground(Color(white: 0.2))
                            }
                        }
                        .listStyle(PlainListStyle())
                        .background(Color.black)
                        .scrollContentBackground(.hidden)
                        .cornerRadius(8)
                        .listSectionSeparatorTint(.red)
                        .padding(.horizontal, 16)
                    } else if !viewModel.query.trimmingCharacters(in: .whitespaces).isEmpty {
                        VStack {
                            Spacer()
                            Text("Nenhum filme encontrado.")
                                .foregroundColor(.gray)
                                .padding()
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color(white: 0.2))
                        .padding([.horizontal, .bottom], 16)
                    }
                }
                .navigationTitle("Filmes")
                .navigationBarTitleDisplayMode(.inline)
                .foregroundColor(.gray)
                .background(Color.gray.opacity(0.2))
                .navigationBarBackButtonHidden(false)
                .navigationBarItems(leading: BackButton())
            }
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
