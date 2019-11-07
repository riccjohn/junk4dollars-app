import XCTest
import UIKit
import Junk4Dollars_app

class AuctionListViewControllerTests: XCTestCase {
    func buildController() -> AuctionListViewController {
        var controller: AuctionListViewController!
        controller = AuctionListViewController()
        let tableView = UITableView()
        controller.auctionTableView = tableView
        return controller
    }

    func testControllerSetsTableViewDataSource() {
        let controller = buildController()
        controller.viewDidLoad()
        XCTAssertNotNil(controller.auctionTableView.dataSource)
    }

    func testDataSourceIs() {
        let controller = buildController()
        controller.viewDidLoad()
        XCTAssert(controller.auctionsDataSource === controller.auctionTableView.dataSource)
    }
}
