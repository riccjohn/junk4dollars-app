import UIKit

public class AuctionDetailsViewController: UIViewController, AuctionDetailsView {

    @IBOutlet public var auctionTitleLabel: UILabel!
    @IBOutlet var auctionDescriptionLabel: UILabel!
    @IBOutlet var auctionPriceLabel: UILabel!
    @IBOutlet var auctionTimeRemainingLabel: UILabel!

    public var auctionId: Int? = nil
    var presenter: AuctionDetailsPresenter?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.auctionTitleLabel?.text = ""
        self.presenter = AuctionDetailsPresenter(view: self)
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        if let id = self.auctionId {
            self.presenter?.loadAuction(id: id)
        }
    }

    public func auctionLoaded(auction: Auction) -> Void {
        DispatchQueue.main.async {
            self.auctionTitleLabel?.text = auction.title
            self.auctionDescriptionLabel?.text = auction.description
            self.auctionPriceLabel?.text = String(auction.starting_price)
            self.auctionTimeRemainingLabel?.text = auction.ends_at
        }
    }
}
