import UIKit
import SnapKit

protocol BaseViewControllerDelegate: AnyObject {}

class BaseViewController: UIViewController {

    // MARK: - Public Properties

    weak var delegate: BaseViewControllerDelegate?
    let navBar = UINavigationBar()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseLayout()
    }

    // MARK: - Private Methods

    private func setupBaseLayout() {
        view.backgroundColor = .systemBlue

        view.addSubview(navBar)
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }

    func addBaseTo(_ contentView: UIView) {
        view.layoutIfNeeded()
        view.addSubview(contentView)

        contentView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func setTitle(_ title: String) {
        let navItem = UINavigationItem(title: title)
        navBar.setItems([navItem], animated: false)
    }
}
