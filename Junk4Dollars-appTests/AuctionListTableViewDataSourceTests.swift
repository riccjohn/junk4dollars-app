import XCTest
import UIKit
import Junk4Dollars_app

class AuctionListTableViewDataSourceTests: XCTestCase {
    func numberOfRowsHardcodedToThree() {
        let dataSource = AuctionListTableViewDataSource()
        XCTAssertEqual(3, dataSource.tableView(UITableView(), numberOfRowsInSection: 0))
    }
}
