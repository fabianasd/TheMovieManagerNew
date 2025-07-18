import SwiftUI

struct TheMovieManagerLoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
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
                        
                        Text("Sign In")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        
                        TextField("Email", text: $viewModel.email)
                            .padding(.horizontal, 12)
                            .frame(height: 48)
                            .background(Color(white: 0.2))
                            .cornerRadius(6)
                            .foregroundColor(.white)
                        
                        SecureField("Password", text: $viewModel.password)
                            .padding(.horizontal, 12)
                            .frame(height: 48)
                            .background(Color(white: 0.2))
                            .cornerRadius(6)
                            .foregroundColor(.white)
                        
                        Button("Login") {
                            viewModel.login()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                        .font(.system(size: 16, weight: .bold))
                        
                        Button("Login via Website") {
                            viewModel.loginViaWebsite()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                        .font(.system(size: 16, weight: .bold))
                        
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
