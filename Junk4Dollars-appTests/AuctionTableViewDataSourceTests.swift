import XCTest
import UIKit
import Junk4Dollars_app

class AuctionTableDataSourceTests: XCTestCase {
    func numberOfRowsHardcodedToThree() {
        let dataSource = AuctionTableViewDataSource()
        XCTAssertEqual(3, dataSource.tableView(UITableView(), numberOfRowsInSection: 0))
    }
}
