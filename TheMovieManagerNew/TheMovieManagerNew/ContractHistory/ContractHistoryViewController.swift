import UIKit
import GNCoreUI

class ContractHistoryViewController: UIViewController, GnBaseProtocol {

    // MARK: Private Properties

    private let presenter: ContractHistoryPresenterProtocol
    private let screen = ContractHistoryScreen()
    let base: GnBaseViewController

    // MARK: Inicialization

    init(presenter: ContractHistoryPresenterProtocol, base: GnBaseViewController) {
        self.presenter = presenter
        self.base = base
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle Methods

    override func loadView() {
        super.loadView()
        screen.delegate = self
        base.delegate = self
        base.navBar.title = "Detalhes da recorrência"
        base.preferredNavBarStyle = .light
        screen.scrollView.delegate = self
        screen.tableView.delegate = self
        screen.tableView.dataSource = self
        addBaseTo(screen)
        presenter.viewDidLoad()
    }
}

// MARK: Methods of GnBaseDelegate

extension ContractHistoryViewController: GnBaseDelegate {

    func gnBaseDidNavBarBackButtonClicked() {
        presenter.backToPreviousScreen()
    }

    func gnBaseAccountDidChange() {
        base.checkPermission(.pixSchedules)
    }

    func gnBaseCheckedPermission(allowed: Bool) {
        if !allowed {
            presenter.backToRoot()
            return
        }
    }
}

// MARK: Methods of ContractHistoryScreenDelegate

extension ContractHistoryViewController: ContractHistoryScreenDelegate {}

// MARK: Methods of ContractHistoryViewProtocol

extension ContractHistoryViewController: ContractHistoryViewProtocol {

    func reloadTableView() {
        DispatchQueue.main.dispatchMainIfNeeded { [weak self] in
            guard let self else { return }
            screen.tableView.reloadData()
            stopPagination()
        }
    }

    func showConfirmCancelBottomSheet(text: String) {
        let view = InformationBottomView(title: "Cancelar agendamento")
        view.continueButtonText = "Cancelar agendamento"
        view.cancelButtonText = "Voltar"
        view.addNewLabel(attributedText: text.withFonts().build().withColor(.efiBodyColor))
        view.delegate = self
        view.tag = 1
        showBottomSheet(with: view)
    }
}

// MARK: Methods of UIScrollViewDelegate

extension ContractHistoryViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height) {
            guard !presenter.viewModel.isPaginating,
                  presenter.viewModel.contractOrigin == .pix else { return }
            startPagination()
        }
    }

    private func startPagination() {
        let spinnerView = GnSpinnerFooterView(frame: CGRect(x: 0, y: 0, width: screen.frame.width, height: 80))
        screen.tableView.tableFooterView = spinnerView
        presenter.isPaginating(true)
        presenter.paginate()
    }

    private func stopPagination() {
        screen.tableView.tableFooterView = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.presenter.isPaginating(false)
        }
    }
}

extension ContractHistoryViewController: InformationBottomViewDelegate {

    func cancelButtonClicked(_ bottomSheet: InformationBottomView) {
        dismissBottomSheet()
    }

    func closeButtonClicked(_ bottomSheet: InformationBottomView) {
        dismissBottomSheet()
    }

    func continueButtonClicked(_ bottomSheet: InformationBottomView) {
        dismissBottomSheet()
        presenter.confirmCancelScheduledPix()
    }

    func showCommunicationFailureScreen() {
        base.showCommunicationFailureScreen()
    }

    func showWifiErrorScreen() {
        base.showWifiErrorScreen()
    }
}

extension ContractHistoryViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.viewModel.recurrentPixesScheduled.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = screen.tableView.dequeueReusableCell(
            withIdentifier: ContractHistoryCell.cellIdentifier,
            for: indexPath
        ) as? ContractHistoryCell else {
            return UITableViewCell()
        }

        guard let model = presenter.viewModel.recurrentPixesScheduled[safe: indexPath.row] else {
            return UITableViewCell()
        }

        cell.delegate = self
        cell.setupCell(with: model)
        cell.setupCellWithContractOrigin(presenter.viewModel.contractOrigin)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard presenter.viewModel.contractOrigin == .pix else { return }
        presenter.schedulePixHistoryClicked(in: indexPath.row)
    }
}

extension ContractHistoryViewController: ContractHistoryCellDelegate {

    func detailButtonWasClicked(_ model: ContractHistoryCellModel) {
        presenter.openBillingRecodDetailOfScheduledPix(model)
    }

    func cancelButtonWasClicked(_ model: ContractHistoryCellModel) {
        presenter.cancelScheduledPixClicked(model)
    }
}
