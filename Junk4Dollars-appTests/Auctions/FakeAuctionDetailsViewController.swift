import Junk4Dollars_app

public class FakeAuctionDetailsViewController: AuctionDetailsView {
    public var auction: Auction? = nil

    public func auctionLoaded(auction: Auction) -> Void {
        self.auction = auction
    }
}
