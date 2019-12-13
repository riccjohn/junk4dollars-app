import UIKit
public protocol AuctionListView {
    func refresh(auctions: [Auction]) -> Void
}
