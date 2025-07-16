import UIKit

public class TheMovieManagerVIPERLoginRouter {

    // MARK: Private Properties

    private weak var viewController: UIViewController?

    // MARK: Static methods

    public static func configuredViewController() -> UIViewController {
        let router = TheMovieManagerVIPERLoginRouter()
        let interactor = TheMovieManagerVIPERLoginInteractor()
        let base = BaseRouter.configuredViewController()

        let presenter = TheMovieManagerVIPERLoginPresenter(
            interactor: interactor,
            router: router
        )

        let viewController = TheMovieManagerVIPERLoginViewController(
            presenter: presenter,
            base: base
        )

        router.viewController = viewController
        presenter.view = viewController
        interactor.output = presenter

        return viewController
    }
}

// MARK: Methods of TheMovieManagerVIPERLoginRouterProtocol

extension TheMovieManagerVIPERLoginRouter: TheMovieManagerVIPERLoginRouterProtocol {}
