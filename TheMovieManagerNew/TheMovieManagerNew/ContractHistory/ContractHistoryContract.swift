import Foundation
import GNCoreInfra
import GNCoreUI

// MARK: View Output (Screen -> View)
protocol ContractHistoryScreenDelegate: AnyObject {}

// MARK: View Output (Presenter -> View)
protocol ContractHistoryViewProtocol: AnyObject {

    func reloadTableView()
    func startLoading()
    func stopLoading()
    func showConnectivityFailureToast()
    func showFailureToast()
    func showToast(ofType type: GnToastType, withMessage message: String)
    func showConfirmCancelBottomSheet(text: String)
    func showCommunicationFailureScreen()
    func showWifiErrorScreen()
}

// MARK: View Input (View -> Presenter)
protocol ContractHistoryPresenterProtocol: AnyObject {

    var viewModel: ContractHistoryViewModel { get }

    func viewDidLoad()
    func backToPreviousScreen()
    func schedulePixHistoryClicked(in position: Int)
    func openBillingRecodDetailOfScheduledPix(_ model: ContractHistoryCellModel)
    func cancelScheduledPixClicked(_ model: ContractHistoryCellModel)
    func confirmCancelScheduledPix()
    func isPaginating(_ isPaginating: Bool)
    func paginate()
    func backToRoot()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol ContractHistoryInteractorProtocol: AnyObject {

    func getRecurrentInformation(filter: PixScheduledFilterModel)
    func cancelScheduledPix(_ endToEndId: String)
    func cancelScheduledByOpen(_ paymentId: String)
    func notifyToStartStatementDetailTransaction(with protocolNumber: Int)
    func notifyBackToRoot()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol ContractHistoryInteractorOutputProtocol: AnyObject {

    func didGetRecurrentScheduledPix(_ model: [ContractHistoryCellModel])
    func didGetRecurrentScheduledPixConnectionFail()
    func didGetRecurrentScheduledPixFail()
    func didCancelScheduledPixSuccessfully()
    func didCancelScheduledPixFailed()
}

// MARK: Router Input (Presenter -> Router)
protocol ContractHistoryRouterProtocol: AnyObject {

    func presentScheduledPixDetails(_ scheduledPixId: String)
    func backToPreviousScreen()
}
