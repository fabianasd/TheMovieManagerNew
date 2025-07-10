import Foundation
// MARK: View Output (Screen -> View)
protocol TheMovieManagerNewScreenDelegate: AnyObject {}

// MARK: View Output (Presenter -> View)
protocol TheMovieManagerNewViewProtocol: AnyObject {}

// MARK: View Input (View -> Presenter)
protocol TheMovieManagerNewPresenterProtocol: AnyObject {

    var viewModel: TheMovieManagerNewViewModel { get }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol TheMovieManagerNewInteractorProtocol: AnyObject {}

// MARK: Interactor Output (Interactor -> Presenter)
protocol TheMovieManagerNewInteractorOutputProtocol: AnyObject {}

// MARK: Router Input (Presenter -> Router)
protocol TheMovieManagerNewRouterProtocol: AnyObject {}
