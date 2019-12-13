import UIKit
public protocol AuctionListView: UIViewController {
    func refreshAuctions(_ auctions: [Auction]) -> Void
}
