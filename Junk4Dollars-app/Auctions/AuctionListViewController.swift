import UIKit

public class AuctionListViewController: UIViewController {
    @IBOutlet public var auctionTableView: UITableView!
    @IBOutlet public var logInOutButton: UIBarButtonItem!

    public let auctionsDataSource = AuctionListTableViewDataSource()

    var authentication: Authentication = AuthenticationDependencies.authentication

    override public func viewDidLoad() {
        super.viewDidLoad()
        auctionTableView.dataSource = auctionsDataSource
    }

    public override func viewWillAppear(_ animated: Bool) {
        loadAuctions()
    }

    @IBAction public func logInOut(_ sender: UIBarButtonItem) {
        if(!authentication.loggedIn) {
            authentication.logIn() {
                self.logInOutButton.title = "Log Out"
            }
        } else {
            authentication.logOut() {
                self.logInOutButton.title = "Log In"
            }
        }
    }

    func loadAuctions() -> Void {
        AuctionsApiService().getAllAuctions { result in
            switch result {
                case .success(let auctions):
                    self.auctionsDataSource.setAuctions(auctions)
                    DispatchQueue.main.async {
                       self.auctionTableView.reloadData()
                    }
                case .error(let message):
                    print("An error occurred: \(message)")
            }
        }
    }
}
