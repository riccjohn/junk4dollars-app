import UIKit

public class AuctionListViewController: UIViewController {
    @IBOutlet public var auctionTableView: UITableView!
    @IBOutlet public var logInOutButton: UIBarButtonItem!

    public let auctionsDataSource = AuctionListTableViewDataSource()

    var authentication: Authentication = Auth0Authentication()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public init(authentication: Authentication) {
        super.init(nibName: nil, bundle: nil)
        self.authentication = authentication
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        auctionTableView.dataSource = auctionsDataSource
    }
    
    @IBAction public func logInOut(_ sender: UIBarButtonItem) {
        if (authentication.loggedIn) {
            authentication.logOut() {
                self.logInOutButton.title = "Log In"
            }

        } else {
            authentication.logIn() { (token) in
                self.logInOutButton.title = "Log Out"
                self.authentication.getUserInfo(token)
                print("TOKEN =>", token)
//                print("USER ?", self.authentication.currentUserProfile?.sub)

//                UserApiService().getSingleUser(userId: 1) { result in
//                    switch result {
//                        case .success(let user):
//                            print("USER DATA =>", user)
//                        case .error(let message):
//                            print("An error occurred: \(message)")
//                    }
//                }
                
//                self.logInOutButton.title = "Hi, \(username)"
//                return user name / id from Rails private route
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
