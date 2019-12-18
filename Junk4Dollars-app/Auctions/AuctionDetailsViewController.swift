import UIKit

public class AuctionDetailsViewController: UIViewController {
    @IBOutlet var AuctionIdLabel: UILabel!
    public var auctionId: Int? = nil

    override public func viewDidLoad() {
        super.viewDidLoad()
        if let auctionId = auctionId {
            AuctionIdLabel.text = "Auction \(auctionId)"
        }
    }
    
}
