import UIKit

public class AuctionListViewController: UIViewController, AuctionListView, UITableViewDelegate {
    @IBOutlet public var auctionTableView: UITableView!
    @IBOutlet public var logInOutButton: UIBarButtonItem!
    @IBOutlet public var welcomeLabel: UILabel!

    public let auctionsDataSource = AuctionListTableViewDataSource()
    var presenter: AuctionListPresenter?

    var authentication: Authentication = AuthenticationDependencies.authentication
    var apiServices = ApiDependencies.apiServices

    public var selectedAutionId: Int? = nil

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeLabel?.text = ""
        auctionTableView.dataSource = auctionsDataSource
        auctionTableView.delegate = self
        self.presenter = AuctionListPresenter(view: self)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewController = segue.destination as! AuctionDetailsViewController
        secondViewController.auctionId = self.selectedAutionId
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        let auction = self.auctionsDataSource.auctionFor(indexPath: indexPath)
        self.selectedAutionId = auction.identifier
        self.performSegue(withIdentifier: "showAuctionDetailsSegue", sender: self)
    }

    private

    func updateUiForLogIn(response: HttpCallResult<User>) -> Void {
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
