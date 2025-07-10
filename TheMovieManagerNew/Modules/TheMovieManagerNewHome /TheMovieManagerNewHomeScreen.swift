import UIKit
import SnapKit

class TheMovieManagerNewScreen: UIView {

    // MARK: Private Properties

    weak var delegate: TheMovieManagerNewScreenDelegate?

    // MARK: Views

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layoutMargins = .init(top: 24, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 24
        return stackView
    }()

    private let historyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Filmes"
        return label
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

extension TheMovieManagerNewScreen: CodeView {

    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addArrangedSubview(historyLabel)
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
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
