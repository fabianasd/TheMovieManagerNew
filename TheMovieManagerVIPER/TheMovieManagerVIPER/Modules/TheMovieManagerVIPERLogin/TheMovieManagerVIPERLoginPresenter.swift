import Foundation

class TheMovieManagerVIPERLoginPresenter {

    // MARK: Private Properties

    weak var view: TheMovieManagerVIPERLoginViewProtocol?
    private var interactor: TheMovieManagerVIPERLoginInteractorProtocol
    private var router: TheMovieManagerVIPERLoginRouterProtocol

    // MARK: Public Properties

    private(set) var viewModel = TheMovieManagerVIPERLoginViewModel()

    // MARK: Inicialization

    init(interactor: TheMovieManagerVIPERLoginInteractorProtocol, router: TheMovieManagerVIPERLoginRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Methods of TheMovieManagerVIPERLoginPresenterProtocol

extension TheMovieManagerVIPERLoginPresenter: TheMovieManagerVIPERLoginPresenterProtocol {}

// MARK: Methods of TheMovieManagerVIPERLoginInteractorOutputProtocol

extension TheMovieManagerVIPERLoginPresenter: TheMovieManagerVIPERLoginInteractorOutputProtocol {}
