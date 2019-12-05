import UIKit

public class AuctionListViewController: UIViewController {
    @IBOutlet public var auctionTableView: UITableView!
    @IBOutlet public var logInOutButton: UIBarButtonItem!
    @IBOutlet public var welcomeLabel: UILabel!

    public let auctionsDataSource = AuctionListTableViewDataSource()

    var authentication: Authentication = AuthenticationDependencies.authentication

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeLabel.text = ""
        auctionTableView.dataSource = auctionsDataSource
    }

    public override func viewWillAppear(_ animated: Bool) {
        loadAuctions()
    }

    @IBAction public func logInOut(_ sender: UIBarButtonItem) {
        if(!authentication.loggedIn) {
            authentication.logIn() {
                self.logInOutButton.title = "Log Out"
                UserApiService().getMyUser() { response in
                    switch response {
                        case .success(let data):
                            DispatchQueue.main.async {
                                self.welcomeLabel.text = "Welcome, \(data.name)!"
                            }
                        default:
                            print("uh oh")
                    }
                }
            }
        } else {
            authentication.logOut() {
                self.logInOutButton.title = "Log In"
                self.welcomeLabel.text = ""
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
