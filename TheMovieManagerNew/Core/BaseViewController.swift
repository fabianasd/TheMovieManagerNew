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
        setupNavigationBarAppearance()
        setupBaseLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }



    // MARK: - Private Methods
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white, // texto branco
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
        navBar.compactAppearance = appearance
        navBar.tintColor = .white
    }
    
    private func setupBaseLayout() {
        view.backgroundColor = .black

        view.addSubview(navBar)
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
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
