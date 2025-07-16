import Foundation
// MARK: View Output (Screen -> View)
protocol TheMovieManagerVIPERLoginScreenDelegate: AnyObject {}

// MARK: View Output (Presenter -> View)
protocol TheMovieManagerVIPERLoginViewProtocol: AnyObject {}

// MARK: View Input (View -> Presenter)
protocol TheMovieManagerVIPERLoginPresenterProtocol: AnyObject {

    var viewModel: TheMovieManagerVIPERLoginViewModel { get }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol TheMovieManagerVIPERLoginInteractorProtocol: AnyObject {}

// MARK: Interactor Output (Interactor -> Presenter)
protocol TheMovieManagerVIPERLoginInteractorOutputProtocol: AnyObject {}

// MARK: Router Input (Presenter -> Router)
protocol TheMovieManagerVIPERLoginRouterProtocol: AnyObject {}
