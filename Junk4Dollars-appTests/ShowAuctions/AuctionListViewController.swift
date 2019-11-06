import XCTest
import UIKit
import Junk4Dollars_app

class AuctionListViewControllerTests: XCTestCase {
    func buildController() -> AuctionListViewController {
        var controller: AuctionListViewController!
        controller = AuctionListViewController()
        let tableView = UITableView()
        controller.auctionTableView = tableView
        controller.viewDidLoad()
        return controller
    }

    func testControllerSetsDataSource() {
        let controller = buildController()
        XCTAssertFalse(controller.auctionTableView.dataSource == nil)
    }
}
