import UIKit
import Auth0

public class AuctionListViewController: UIViewController {
    @IBOutlet public var auctionTableView: UITableView!
    @IBOutlet var logInOutButton: UIBarButtonItem!

    public let auctionsDataSource = AuctionListTableViewDataSource()
    let credentialsManager = CredentialsManager(authentication: Auth0.authentication())

    var loggedIn = false

    override public func viewDidLoad() {
        super.viewDidLoad()
        auctionTableView.dataSource = auctionsDataSource
    }

    func auth0LogOut() {
        print("Logging out ...")
        Auth0
        .webAuth()
        .clearSession(federated:false) {
            switch $0 {
                case true:
                    print("Logged out")
                    self.loggedIn = false
                    self.logInOutButton.title = "Log In"
                case false:
                   print("Error logging out")
            }
        }
    }

    func auth0LogIn() {
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
                    self.loggedIn = true
                    self.logInOutButton.title = "Log Out"
                    print("Credentials: \(credentials)")
                }
        }
    }

    @IBAction func logInOut(_ sender: UIBarButtonItem) {
        if (self.loggedIn) {
            self.auth0LogOut()

        } else {
            self.auth0LogIn()
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
