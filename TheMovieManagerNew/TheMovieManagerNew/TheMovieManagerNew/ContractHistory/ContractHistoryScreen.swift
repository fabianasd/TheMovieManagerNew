import UIKit
import GNCoreUI

class ContractHistoryScreen: UIView {

    // MARK: Private Properties

    weak var delegate: ContractHistoryScreenDelegate?

    // MARK: Views

    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layoutMargins = .init(top: 24, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 24
        return stackView
    }()

    private var historyLabel: UILabel = {
        let label = UILabel()
        label.font = .subheadingBold
        label.textColor = .efiBodyColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Histórico"
        return label
    }()

    lazy var tableView: AutoresizebleTableView = {
        let tableView = AutoresizebleTableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ContractHistoryCell.self, forCellReuseIdentifier: ContractHistoryCell.cellIdentifier)
        tableView.backgroundColor = .efiBodyColorInverse
        tableView.bounces = false
        return tableView
    }()

    // MARK: Inicialization

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Methods of Code View Protocol

extension ContractHistoryScreen: CodeView {

    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addArrangedSubview(historyLabel)
        containerView.addArrangedSubview(tableView)
    }

    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(self)
        }
    }
}
