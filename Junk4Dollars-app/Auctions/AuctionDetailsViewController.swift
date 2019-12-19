import UIKit

public class AuctionDetailsViewController: UIViewController, AuctionDetailsView {

    @IBOutlet public var auctionTitleLabel: UILabel!
    @IBOutlet public var auctionDescriptionLabel: UILabel!
    @IBOutlet public var auctionPriceLabel: UILabel!
    @IBOutlet public var auctionTimeRemainingLabel: UILabel!

    public var auctionId: Int? = nil
    var presenter: AuctionDetailsPresenter?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.auctionTitleLabel?.text = ""
        self.auctionDescriptionLabel?.text = ""
        self.auctionPriceLabel?.text = ""
        self.auctionTimeRemainingLabel?.text = ""
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

            let price = Price(inCents: auction.starting_price).inDollars()
            self.auctionPriceLabel?.text = price
            self.auctionTimeRemainingLabel?.text = auction.ends_at
        }
    }
}
