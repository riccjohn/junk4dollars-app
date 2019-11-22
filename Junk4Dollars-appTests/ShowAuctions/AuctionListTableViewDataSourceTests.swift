import XCTest
import UIKit
import Junk4Dollars_app

class AuctionListTableViewDataSourceTests: XCTestCase {
    func testDataSource_SetsCorrectNumberOfCells() {
        let dataSource = AuctionListTableViewDataSource()

        let auctions = [
            Auction(identifier: 1, title: "Title One"),
            Auction(identifier: 2, title: "Title Two")
        ]

        let tableView = UITableView()

        var numberOfRowsInSectionZero = dataSource.tableView(tableView, numberOfRowsInSection: 0)


        XCTAssertEqual(0, numberOfRowsInSectionZero)

        dataSource.setAuctions(auctions)
        numberOfRowsInSectionZero = dataSource.tableView(tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(auctions.count, numberOfRowsInSectionZero)
    }

    func testDataSource_SetsTitleOfCellCorrectly() {
        let dataSource = AuctionListTableViewDataSource()

        let auctions = [
            Auction(identifier: 1, title: "Title One"),
            Auction(identifier: 2, title: "Title Two")
        ]

        dataSource.setAuctions(auctions)
        let tableView = UITableView()
        let indexPathZero = IndexPath(indexes: [0, 0])
        let titleOfFirstCell = dataSource.tableView(tableView, cellForRowAt: indexPathZero)

        XCTAssertEqual(auctions[0].title, titleOfFirstCell.textLabel?.text)
    }
}
