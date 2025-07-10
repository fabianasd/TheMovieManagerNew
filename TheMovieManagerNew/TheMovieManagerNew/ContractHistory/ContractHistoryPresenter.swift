import Foundation
import Factory

class ContractHistoryPresenter {

    // MARK: Private Properties

    weak var view: ContractHistoryViewProtocol?
    private var interactor: ContractHistoryInteractorProtocol
    private var router: ContractHistoryRouterProtocol
    @Injected(\.secureDeviceMiddleware) var secureDeviceMiddleware

    // MARK: Public Properties

    private(set) var viewModel: ContractHistoryViewModel
    private(set) var page = 1
    private(set) var paginationLimit = 15

    // MARK: Inicialization

    init(
        interactor: ContractHistoryInteractorProtocol,
        router: ContractHistoryRouterProtocol,
        viewModel: ContractHistoryViewModel
    ) {
        self.interactor = interactor
        self.router = router
        self.viewModel = viewModel
    }
}

// MARK: Methods of ContractHistoryPresenterProtocol

extension ContractHistoryPresenter: ContractHistoryPresenterProtocol {

    func viewDidLoad() {
        switch viewModel.contractOrigin {
        case .pix:
            cleanRecurrencesScheduled()
            view?.startLoading()
            interactor.getRecurrentInformation(filter: viewModel.createFilterRequestModel(page: page))
        case .openFinance:
            view?.reloadTableView()
        }
    }

    private func cleanRecurrencesScheduled() {
        page = 1
        viewModel.recurrentPixesScheduled = []
    }

    func backToPreviousScreen() {
        router.backToPreviousScreen()
    }

    func openBillingRecodDetailOfScheduledPix(_ model: ContractHistoryCellModel) {
        guard let protocolNumber = model.protocolNumber else {
            view?.showFailureToast()
            return
        }

        interactor.notifyToStartStatementDetailTransaction(with: protocolNumber)
    }

    func schedulePixHistoryClicked(in position: Int) {
        guard let model = viewModel.recurrentPixesScheduled[safe: position] else {
            view?.showFailureToast()
            return
        }
        router.presentScheduledPixDetails(model.endToEndId)
    }

    func cancelScheduledPixClicked(_ model: ContractHistoryCellModel) {
        if model.scheduledAt.isToday {
            let message = "O agendamento pode ser cancelado até às 23:59 do dia anterior à data informada."
            view?.showToast(ofType: .info, withMessage: message)
            return
        }

        let isByPix = viewModel.contractOrigin == .pix
        let paymentId = model.paymentId ?? ""
        viewModel.schedulePixIDToCancel = isByPix ? model.endToEndId : paymentId

        let detailText = makeCancelDetailText(model)
        view?.showConfirmCancelBottomSheet(
            text: """
            Ao continuar, o pagamento será cancelado, mas os próximos Pix agendados não serão afetados.

            Deseja cancelar o Pix agendado para \(model.nameText + detailText)?
            """
        )
    }

    private func makeCancelDetailText(_ model: ContractHistoryCellModel) -> String {
        guard viewModel.contractOrigin == .pix else { return "" }
        let value = model.value.convertToBRL()
        let receiverName = model.receiverName.capitalized
        return " para **“\(receiverName)”** no valor de **\(value)**"
    }

    func confirmCancelScheduledPix() {
        switch viewModel.contractOrigin {
        case .pix:
            let pixId = viewModel.schedulePixIDToCancel
            checkSecureDevice { [weak self] in self?.interactor.cancelScheduledPix(pixId) }
        case .openFinance:
            let paymentId = viewModel.schedulePixIDToCancel
            checkSecureDevice { [weak self] in self?.interactor.cancelScheduledByOpen(paymentId) }
        }
    }

    private func checkSecureDevice(onRegistered: @escaping () -> Void) {
        view?.startLoading()
        secureDeviceMiddleware.check(shouldAnimatePop: true) { [weak self] status in
            switch status {
            case .registered:
                onRegistered()
            case .registrationCanceled:
                self?.view?.stopLoading()
            case .error:
                self?.view?.stopLoading()
                self?.view?.showFailureToast()
            }
        }
    }

    func isPaginating(_ isPaginating: Bool) {
        viewModel.isPaginating = true
    }

    func paginate() {
        interactor.getRecurrentInformation(filter: viewModel.createFilterRequestModel(page: page))
    }

    func backToRoot() {
        interactor.notifyBackToRoot()
    }
}

// MARK: Methods of ContractHistoryInteractorOutputProtocol

extension ContractHistoryPresenter: ContractHistoryInteractorOutputProtocol {

    func didGetRecurrentScheduledPix(_ model: [ContractHistoryCellModel]) {
        if model.count >= paginationLimit {
            page += 1
        }

        let recurrentPixesScheduled = model.filter { !(viewModel.recurrentPixesScheduled.contains($0)) }
        viewModel.recurrentPixesScheduled.append(contentsOf: recurrentPixesScheduled)

        view?.reloadTableView()
        view?.stopLoading()
    }

    func didGetRecurrentScheduledPixConnectionFail() {
        view?.showWifiErrorScreen()
        view?.stopLoading()
    }

    func didGetRecurrentScheduledPixFail() {
        view?.showCommunicationFailureScreen()
        view?.stopLoading()
    }

    func didCancelScheduledPixSuccessfully() {
        view?.stopLoading()
        view?.showToast(ofType: .success, withMessage: "Tudo certo! O agendamento foi cancelado.")
    }

    func didCancelScheduledPixFailed() {
        view?.stopLoading()
        view?.showToast(
            ofType: .error,
            withMessage: "Houve um erro ao tentar cancelar o agendamento. Por favor, tente novamente."
        )
    }
}
