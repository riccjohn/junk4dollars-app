import UIKit

class AuctionListViewController: UIViewController {
    @IBOutlet var auctionTableView: UITableView!
    
    let auctionsDataSource = AuctionListTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auctionTableView.dataSource = auctionsDataSource
    }
}
