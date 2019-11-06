import XCTest
import UIKit
import Junk4Dollars_app

class AuctionListTableViewDataSourceTests: XCTestCase {
    var dataSource: UITableViewDataSource!

    func setupDataSource() {
        dataSource = AuctionListTableViewDataSource()
    }

    func testNumberOfRowsHardcodedToThree() {
        setupDataSource()
        XCTAssertEqual(3, dataSource.tableView(UITableView(), numberOfRowsInSection: 0))
    }

    func testHardcodedFirstCellTitle() {
        setupDataSource()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = dataSource.tableView(UITableView(), cellForRowAt: indexPath)
        XCTAssertEqual("Throne of Eldraine Booster Box", cell.textLabel?.text)
    }
}
