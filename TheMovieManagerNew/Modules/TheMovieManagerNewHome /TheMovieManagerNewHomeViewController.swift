import UIKit

public class TheMovieManagerNewViewController: UIViewController {

    // MARK: Private Properties

    let presenter: TheMovieManagerNewPresenterProtocol
    fileprivate let screen = TheMovieManagerNewScreen()
    let base: BaseViewController

    // MARK: Inicialization

    init(
        presenter: TheMovieManagerNewPresenterProtocol,
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
        base.setTitle("The Movie")
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

extension TheMovieManagerNewViewController: BaseViewControllerDelegate {}

// MARK: Methods of TheMovieManagerNewScreenDelegate

extension TheMovieManagerNewViewController: TheMovieManagerNewScreenDelegate {}

// MARK: Methods of TheMovieManagerNewViewProtocol

extension TheMovieManagerNewViewController: TheMovieManagerNewViewProtocol {}

