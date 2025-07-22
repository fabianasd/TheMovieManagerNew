import SwiftUI

public struct TheMovieManagerLoginView: View {
    @StateObject var viewModel: LoginViewModel

    public init(viewModel: LoginViewModel) {
         _viewModel = StateObject(wrappedValue: viewModel)
     }

    public var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            Text("THE MOVIE")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                            
                            Spacer().frame(height: 48)
                            
                            Text("Sign In")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            
                            TextField("", text: $viewModel.username, prompt: Text("Email").foregroundColor(.white.opacity(0.2)))
                                .padding(.horizontal, 12)
                                .frame(height: 48)
                                .background(Color(white: 0.2))
                                .cornerRadius(6)
                                .foregroundColor(.white)
                                .autocapitalization(.none)
                            
                            SecureField("", text: $viewModel.password, prompt: Text("Password").foregroundColor(.white.opacity(0.2)))
                                .padding(.horizontal, 12)
                                .frame(height: 48)
                                .background(Color(white: 0.2))
                                .cornerRadius(6)
                                .foregroundColor(.white)
                            
                            Spacer().frame(height: 30)
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                            } else {
                                Button("Login") {
                                    Task {
                                        await viewModel.login()
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .font(.system(size: 16, weight: .bold))
                            }
                            
                            if let error = viewModel.errorMessage {
                                Text(error)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                            }
                            
                            Spacer().frame(height: 48)
                        }
                        .padding(.top, 30)
                        .padding(.horizontal, 16)
                    }
                    
                    Text("This product uses the TMDb API but is not endorsed or certified by TMDb.")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    
                    NavigationLink(
                        destination: TheMovieManagerSearchView(viewModel: SearchViewModel()),
                        isActive: $viewModel.isAuthenticated
                    ) {
                        EmptyView()
                    }
                }
            }
        }
    }
}

#if DEBUG
struct TheMovieManagerLoginView_Previews: PreviewProvider {
    static var previews: some View {
        TheMovieManagerLoginView(viewModel: LoginViewModel())
            .previewDevice("iPhone 14")
    }
}
#endif
