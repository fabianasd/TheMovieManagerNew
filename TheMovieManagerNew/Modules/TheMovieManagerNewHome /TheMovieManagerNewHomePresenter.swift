import Foundation

class TheMovieManagerNewPresenter {

    // MARK: Private Properties

    weak var view: TheMovieManagerNewViewProtocol?
    private var interactor: TheMovieManagerNewInteractorProtocol
    private var router: TheMovieManagerNewRouterProtocol

    // MARK: Public Properties

    private(set) var viewModel = TheMovieManagerNewViewModel()

    // MARK: Inicialization

    init(interactor: TheMovieManagerNewInteractorProtocol, router: TheMovieManagerNewRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Methods of TheMovieManagerNewPresenterProtocol

extension TheMovieManagerNewPresenter: TheMovieManagerNewPresenterProtocol {}

// MARK: Methods of TheMovieManagerNewInteractorOutputProtocol

extension TheMovieManagerNewPresenter: TheMovieManagerNewInteractorOutputProtocol {}
