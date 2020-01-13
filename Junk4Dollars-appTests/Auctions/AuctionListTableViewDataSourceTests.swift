import XCTest
import UIKit
import Junk4Dollars_app

class AuctionListTableViewDataSourceTests: XCTestCase {
    func testDataSource_SetsCorrectNumberOfCells() {
        let dataSource = AuctionListTableViewDataSource()

        let auctions = [
            Auction(identifier: 1, title: "Title One", description: "foo", startingPrice: 1000, endsAt: "2019-11-01T20:35:21.000Z"),
            Auction(identifier: 2, title: "Title Two", description: "bar", startingPrice: 3000, endsAt: "2019-11-01T20:35:21.000Z")
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
            Auction(identifier: 1, title: "Title One", description: "foo", startingPrice: 1000, endsAt: "2019-11-01T20:35:21.000Z"),
            Auction(identifier: 2, title: "Title Two", description: "bar", startingPrice: 3000, endsAt: "2019-11-01T20:35:21.000Z")
        ]

        dataSource.setAuctions(auctions)
        let tableView = UITableView()
        let indexPathZero = IndexPath(indexes: [0, 0])
        let titleOfFirstCell = dataSource.tableView(tableView, cellForRowAt: indexPathZero)

        XCTAssertEqual(auctions[0].title, titleOfFirstCell.textLabel?.text)
    }

    func testAuctionFor_returnsAuctionId_givenAnIndexPath() {
        let auctions = [
            Auction(identifier: 111, title: "Throne of Eldraine Booster Box", description: "New", startingPrice: 8500, endsAt: "2019-11-01T20:35:21.000Z"),
            Auction(identifier: 222, title: "M20 Booster Box", description: "Unopened", startingPrice: 8300, endsAt: "2019-11-01T20:35:21.000Z")
        ]
        
        let dataSource = AuctionListTableViewDataSource()
        dataSource.auctions = auctions

        let auctionOne = dataSource.auctionFor(indexPath: [0, 0])
        let auctionTwo = dataSource.auctionFor(indexPath: [0, 1])

        XCTAssertEqual(auctions[0].identifier, auctionOne.identifier)
        XCTAssertEqual(auctions[1].identifier, auctionTwo.identifier)
    }
}
