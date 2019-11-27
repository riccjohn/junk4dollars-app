import UIKit
import Auth0

public class AuctionListViewController: UIViewController {
    @IBOutlet public var auctionTableView: UITableView!
    @IBOutlet var logInOutButton: UIBarButtonItem!

    public let auctionsDataSource = AuctionListTableViewDataSource()

    let authentication = Authentication()

    override public func viewDidLoad() {
        super.viewDidLoad()
        auctionTableView.dataSource = auctionsDataSource
    }



    @IBAction func logInOut(_ sender: UIBarButtonItem) {
        if (authentication.loggedIn) {
            authentication.logOut() {
                self.logInOutButton.title = "Log In"
            }

        } else {
            authentication.logIn() {
                self.logInOutButton.title = "Log Out"
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
