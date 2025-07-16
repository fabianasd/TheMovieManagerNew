import UIKit

public class TheMovieManagerVIPERLoginViewController: UIViewController {

    // MARK: Private Properties

    let presenter: TheMovieManagerVIPERLoginPresenterProtocol
    fileprivate let screen = TheMovieManagerVIPERLoginScreen()
    let base: BaseViewController

    // MARK: Inicialization

    init(
        presenter: TheMovieManagerVIPERLoginPresenterProtocol,
        base: BaseViewController
    ) {
        self.presenter = presenter
        self.base = base
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle Methods

    public override func viewDidLoad() {
        super.viewDidLoad()

        screen.delegate = self
        base.delegate = self
        base.setTitle("")
        base.addBaseTo(screen)

        addChild(base)
        view.addSubview(base.view)
        base.view.frame = view.bounds
        base.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        base.didMove(toParent: self)

        view.backgroundColor = .black
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    public override var childForStatusBarStyle: UIViewController? {
        return base
    }

}

extension TheMovieManagerVIPERLoginViewController: BaseViewControllerDelegate {}

// MARK: Methods of TheMovieManagerVIPERLoginScreenDelegate

extension TheMovieManagerVIPERLoginViewController: TheMovieManagerVIPERLoginScreenDelegate {}

// MARK: Methods of TheMovieManagerVIPERLoginViewProtocol

extension TheMovieManagerVIPERLoginViewController: TheMovieManagerVIPERLoginViewProtocol {}

