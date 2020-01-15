import UIKit

public class AuctionListTableViewDataSource: NSObject, UITableViewDataSource {

    public var auctions: [Auction] = []

    public func setAuctions(_ newAuctions: [Auction]) -> Void {
        auctions = newAuctions
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = auctionFor(indexPath: indexPath)?.title
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return auctions.count
    }

    public func auctionFor(indexPath: IndexPath) -> Auction? {

        guard indexPath.row <= auctions.count else {
            return nil
        }

        return auctions[indexPath.row]
    }
}
