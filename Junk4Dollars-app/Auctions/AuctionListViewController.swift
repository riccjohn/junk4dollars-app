import UIKit

public class AuctionListViewController: UIViewController, AuctionListView, UITableViewDelegate {
    @IBOutlet public var auctionTableView: UITableView!
    @IBOutlet public var logInOutButton: UIBarButtonItem!
    @IBOutlet public var welcomeLabel: UILabel!

    public let auctionsDataSource = AuctionListTableViewDataSource()
    var presenter: AuctionListPresenter?

    var authentication: Authentication = AuthenticationDependencies.authentication
    var apiServices = ApiDependencies.apiServices

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeLabel?.text = ""
        auctionTableView.dataSource = auctionsDataSource
        auctionTableView.delegate = self
        self.presenter = AuctionListPresenter(view: self)
    }

    public override func viewWillAppear(_ animated: Bool) {
        self.presenter?.loadAuctions()
    }

    @IBAction public func logInOut(_ sender: UIBarButtonItem) {
        if(!authentication.loggedIn) {
            authentication.logIn() {
                self.apiServices.getMyUser() { response in
                    self.updateUiForLogIn(response: response)
                }
            }
        } else {
            authentication.logOut() {
                self.updateUiForLogOut()
            }
        }
    }

    public func refresh(auctions: [Auction]) -> Void {
        self.auctionsDataSource.setAuctions(auctions)
        DispatchQueue.main.async {
            self.auctionTableView.reloadData()
        }
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        self.auctionsDataSource.auctionFor(indexPath: indexPath) { id in
            print("ROW => \(indexPath.row) ID =>", id)
        }
    }

    private

    func updateUiForLogIn(response: HttpCallResult<User> ) -> Void {
        switch response {
            case .success(let data):
                DispatchQueue.main.async {
                    self.logInOutButton.title = "Log Out"
                    self.welcomeLabel.text = "Welcome, \(data.name)!"
                }
            case .error(let message):
                print("An error occurred: \(message)")
        }
    }

    func updateUiForLogOut() -> Void {
        self.logInOutButton.title = "Log In"
        self.welcomeLabel?.text = ""
    }


}
