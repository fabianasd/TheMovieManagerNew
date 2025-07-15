import GNCoreInfra

struct ContractHistoryViewModel {

    let contractId: Int
    let contractOrigin: ContractOriginType
    var recurrentPixesScheduled: [ContractHistoryCellModel]
    var isPaginating = false
    var schedulePixIDToCancel = ""
    var filter = MoreFilterViewModel(filterTabOption: .scheduled)
}

extension ContractHistoryViewModel {

    func createFilterRequestModel(page: Int) -> PixScheduledFilterModel {
        .init(
            page: page,
            sort: "desc",
            transactionType: "auto",
            contractId: contractId
        )
    }
}
