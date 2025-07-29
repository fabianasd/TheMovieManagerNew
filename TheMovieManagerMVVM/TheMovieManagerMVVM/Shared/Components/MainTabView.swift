import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                TheMovieManagerSearchView(viewModel: SearchViewModel())
            }
            .tabItem {
                Label("Pesquisar", systemImage: "magnifyingglass")
            }

            NavigationView {
                TheMovieManagerFavoritesView(viewModel: TheMovieManagerFavoritesViewModel())
                    .navigationTitle("Favoritos")
            }
            .tabItem {
                Label("Favoritos", systemImage: "heart.fill")
            }

            NavigationView {
                TheMovieManagerWatchlistView(viewModel: TheMovieManagerWatchlistViewModel())
                    .navigationTitle("Salvos")
            }
            .tabItem {
                Label("Salvos", systemImage: "eye.fill")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#if DEBUG
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .previewDevice("iPhone 14")
    }
}
#endif
