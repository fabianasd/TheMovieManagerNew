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
        stackView.layoutMargins = .init(top: 30, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 24
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "THE MOVIE"
        label.textColor = .red
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let signLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private let emailField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [
                .foregroundColor: UIColor(white: 1.0, alpha: 0.5),
                .font: UIFont.systemFont(ofSize: 16)
            ]
        )
        textField.backgroundColor = UIColor(white: 0.2, alpha: 1)
        textField.textColor = .white
        textField.layer.cornerRadius = 6
        textField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        textField.setLeftPaddingPoints(12)
        return textField
    }()
    
    private let passwordField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [
                .foregroundColor: UIColor(white: 1.0, alpha: 0.5),
                .font: UIFont.systemFont(ofSize: 16)
            ]
        )
        textField.backgroundColor = UIColor(white: 0.2, alpha: 1)
        textField.textColor = .white
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 6
        textField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        textField.setLeftPaddingPoints(12)
        return textField
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return button
    }()
    
    private let signInWebsiteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login via Website", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return button
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This product uses the TMDb API but is not endorsed or certified by TMDb."
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
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
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(signLabel)
        containerView.addArrangedSubview(emailField)
        containerView.addArrangedSubview(passwordField)
        containerView.addArrangedSubview(signInButton)
        containerView.addArrangedSubview(signInWebsiteButton)
        containerView.addArrangedSubview(spacerView)
        containerView.addArrangedSubview(descriptionLabel)
    }

    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(self)
            make.height.greaterThanOrEqualTo(self.snp.height) // 👈 ADICIONE ESTA LINHA
        }

    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .black
        containerView.setCustomSpacing(50, after: titleLabel)
        containerView.setCustomSpacing(50, after: passwordField)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
