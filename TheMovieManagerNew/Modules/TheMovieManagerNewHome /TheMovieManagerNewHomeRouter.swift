import UIKit

public class TheMovieManagerNewRouter {

    // MARK: Private Properties

    private weak var viewController: UIViewController?

    // MARK: Static methods

    public static func configuredViewController() -> UIViewController {
        let router = TheMovieManagerNewRouter()
        let interactor = TheMovieManagerNewInteractor()
        let base = BaseRouter.configuredViewController()

        let presenter = TheMovieManagerNewPresenter(
            interactor: interactor,
            router: router
        )

        let viewController = TheMovieManagerNewViewController(
            presenter: presenter,
            base: base
        )

        router.viewController = viewController
        presenter.view = viewController
        interactor.output = presenter

        return viewController
    }
}

// MARK: Methods of TheMovieManagerNewRouterProtocol

extension TheMovieManagerNewRouter: TheMovieManagerNewRouterProtocol {}
