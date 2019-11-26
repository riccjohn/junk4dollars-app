import UIKit
import Auth0

public class AuctionListViewController: UIViewController {
    @IBOutlet public var auctionTableView: UITableView!
    @IBOutlet var logInOutButton: UIBarButtonItem!

    public let auctionsDataSource = AuctionListTableViewDataSource()
    let credentialsManager = CredentialsManager(authentication: Auth0.authentication())

    override public func viewDidLoad() {
        super.viewDidLoad()
        auctionTableView.dataSource = auctionsDataSource
    }


    @IBAction func displayLogIn(_ sender: UIBarButtonItem) {
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://dev-whnyp6fr.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    // Do something with credentials e.g.: save them.
                    // Auth0 will automatically dismiss the login page
                    self.credentialsManager.store(credentials: credentials)
                    print("Credentials: \(credentials)")
                }
        }
    }

    @IBAction func showLogoutController(_ sender: UIButton) {
        Auth0
        .webAuth()
        .clearSession(federated:false) {
            switch $0 {
                case true:
                    print("Logged out")
                case false:
                   print("Error logging out")
            }
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        loadAuctions()
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
