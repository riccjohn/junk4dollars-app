import UIKit

public class AuctionListTableViewDataSource: NSObject, UITableViewDataSource {
    var auctions: [Auction] = AuctionsApiService.getAllAuctions()

    public func setAuctions(_ newAuctions: [Auction]) -> Void {
        auctions = newAuctions
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = auctions[indexPath.row].title
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return auctions.count
    }
}
