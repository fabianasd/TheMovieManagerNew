import Foundation
import Combine
import GNCoreUtils
import GNCoreInfra
import Factory

class ContractHistoryInteractor {

    // MARK: Private Properties

    weak var output: ContractHistoryInteractorOutputProtocol?
    @Injected(\.electronicSignatureMiddleware) private var electronicSignatureMiddleware
    @Injected(\.pixDataAccess) private var pixDataAccess
    @Injected(\.sessionDataAccess) private var sessionDataAccess
    @Injected(\.openFinanceDataAccess) private var openFinanceDataAccess
    @Injected(\.pixNotificationCenter) private var pixNotificationCenter
    var cancellables: Set<AnyCancellable> = []
}

// MARK: Methods of ContractHistoryInteractorProtocol

extension ContractHistoryInteractor: ContractHistoryInteractorProtocol {

    func getRecurrentInformation(filter: PixScheduledFilterModel) {
        pixDataAccess.getSchedules(filter: filter) { [weak self] result in
            switch result {
            case .success(let collection):
                do {
                    let model = try collection.schedules.map { try $0.mapToContractHistoryCellModel() }
                    self?.output?.didGetRecurrentScheduledPix(model)
                } catch {
                    self?.output?.didGetRecurrentScheduledPixFail()
                }
            case .failure:
                self?.output?.didGetRecurrentScheduledPixFail()
            }
        }
    }

    func cancelScheduledPix(_ endToEndId: String) {
        pixDataAccess.cancelScheduledPix(endToEndId: endToEndId) { [weak self] result in
            switch result {
            case .success(let aeToken):
                self?.authorizeTransaction(with: aeToken)
            case .failure:
                self?.output?.didCancelScheduledPixFailed()
            }
        }
    }

    func cancelScheduledByOpen(_ paymentId: String) {
        Task { [weak self] in
            guard let self else { return }
            do {
                let model = try makeOpenFinanceCancelScheduleModel(paymentId)
                let aeToken = try await openFinanceDataAccess.patchCancelScheduled(model)
                authorizeTransaction(with: aeToken)
            } catch {
                output?.didCancelScheduledPixFailed()
            }
        }
    }

    private func makeOpenFinanceCancelScheduleModel(
        _ paymentId: String
    ) throws -> OpenFinanceCancelScheduleModel {
        guard let document = getUserDocument() else { throw HttpError.unexpected }
        return .init(recurringPaymentId: paymentId, document: document)
    }

    private func getUserDocument() -> String? {
        let loggedInUser = sessionDataAccess.getLoggedInUser()
        return loggedInUser?.corporation?.cnpj ?? loggedInUser?.admin?.cpf
    }

    private func authorizeTransaction(with aeToken: String) {
        electronicSignatureMiddleware.authorize(aeToken: aeToken, shouldAnimatePop: true) { [weak self] status in
            switch status {
            case .authorized:
                self?.output?.didCancelScheduledPixSuccessfully()
            case .canceled: break
            case .error:
                self?.output?.didCancelScheduledPixFailed()
            }
        }
    }

    func notifyToStartStatementDetailTransaction(with protocolNumber: Int) {
        let redirect: RedirectData = (.statementDetailTransaction, ["\(protocolNumber)"])
        pixNotificationCenter.post(name: .didRedirect, object: redirect)
    }

    func notifyBackToRoot() {
        NotificationCenter.default.post(name: .backToRoot, object: nil)
    }
}
