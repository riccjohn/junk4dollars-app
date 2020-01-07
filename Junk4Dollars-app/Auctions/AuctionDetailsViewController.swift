import UIKit

public class AuctionDetailsViewController: UIViewController, AuctionDetailsView {

    @IBOutlet public var auctionTitleLabel: UILabel!
    @IBOutlet public var auctionDescriptionLabel: UILabel!
    @IBOutlet public var auctionPriceLabel: UILabel!
    @IBOutlet public var auctionTimeRemainingLabel: UILabel!
    @IBOutlet public var bidPriceInput: UITextField!
    @IBOutlet public var bidButton: UIButton!

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

    @IBAction public func submitBid(_ sender: UIButton) {
        if var inputString = bidPriceInput.text {
            guard(inputString.contains(".")) else {
                print("PLEASE INPUT DECIMAL")
                return
            }

            inputString = inputString.split(separator: ".").joined()
            let inputNumber: Int? = Int(inputString)

            guard inputNumber != nil else {
                print("Error converting String to Int")
                return
            }

            guard self.auctionId != nil else {
                print("Auction id was not set properly")
                return
            }

            self.presenter?.submitBid(auctionId: self.auctionId!, price: inputNumber!)
        }
    }

    public func auctionLoaded(auction: Auction) -> Void {
        DispatchQueue.main.async {
            self.auctionTitleLabel?.text = auction.title
            self.auctionDescriptionLabel?.text = auction.description

            var price: String

            if let bid = auction.bid {
                price = Price(inCents: bid.price).inDollars()
            } else {
                price = Price(inCents: auction.starting_price).inDollars()
            }

            self.auctionPriceLabel?.text = price

            let endTime = Time(utc: auction.ends_at).local()
            self.auctionTimeRemainingLabel?.text = endTime
        }
    }
}
