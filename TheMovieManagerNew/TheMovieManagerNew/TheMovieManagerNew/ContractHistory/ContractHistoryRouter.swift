import UIKit
import GNCoreUI

class ContractHistoryRouter {

    // MARK: Private Properties

    private weak var viewController: UIViewController?

    // MARK: Static methods

    static func configuredViewController(
        _ viewModel: ContractHistoryViewModel
    ) -> UIViewController {
        let router = ContractHistoryRouter()
        let interactor = ContractHistoryInteractor()
        let base = GnBaseRouter.configuredViewController()

        let presenter = ContractHistoryPresenter(
            interactor: interactor,
            router: router,
            viewModel: viewModel
        )

        let viewController = ContractHistoryViewController(
            presenter: presenter,
            base: base
        )

        router.viewController = viewController
        presenter.view = viewController
        interactor.output = presenter

        return viewController
    }
}

// MARK: Methods of ContractHistoryRouterProtocol

extension ContractHistoryRouter: ContractHistoryRouterProtocol {

    func presentScheduledPixDetails(_ scheduledPixId: String) {
        let controller = ScheduleDetailsRouter.configuredViewController(scheduledPixId)
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }

    func backToPreviousScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
