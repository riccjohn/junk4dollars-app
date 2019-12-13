import Junk4Dollars_app

public class FakeAuctionListViewController: AuctionListView {
    public var auctions: [Auction] = []

    public func refresh(auctions: [Auction]) {
        self.auctions = auctions
    }
}
