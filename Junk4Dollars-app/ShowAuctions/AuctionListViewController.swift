import UIKit

public class AuctionListViewController: UIViewController {
    @IBOutlet public var auctionTableView: UITableView!
    
    public let auctionsDataSource = AuctionListTableViewDataSource()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        auctionTableView.dataSource = auctionsDataSource
    }

    public override func viewWillAppear(_ animated: Bool) {
        loadAuctions()
    }

    func loadAuctions() -> Void {
        AuctionsApiService().getAllAuctions { auctions, error in
            if let updatedAuctions = auctions {
                self.auctionsDataSource.setAuctions(updatedAuctions)
            }

            if let error = error {
                print(error.localizedDescription)
            }

            DispatchQueue.main.async {
               self.auctionTableView.reloadData()
            }
        }
    }
}
