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
        self.updateUIForLogInState()

        if let id = self.auctionId {
            self.presenter?.loadAuction(id: id)
        }
    }

    @IBAction public func submitBid(_ sender: UIButton) {
        if var inputString = bidPriceInput.text {
            guard(inputString.contains(".")) else {
                self.displaySimpleAlert(title: "Missing decimal", message: "Please include a decimal in price")
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
            self.clearInput()
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

    private func clearInput() -> Void {
        DispatchQueue.main.async {
            self.bidPriceInput.text = ""
        }
    }

    private

    func displaySimpleAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"MISSING\" \"DECIMAL\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func updateUIForLogInState() {
        if(self.checkLoggedIn()) {
            self.bidButton.isHidden = false
            self.bidPriceInput.isHidden = false
        } else {
            self.bidButton.isHidden = true
            self.bidPriceInput.isHidden = true
        }
    }

    func checkLoggedIn() -> Bool {
        return AuthenticationDependencies.authentication.checkValidToken()
    }
}
