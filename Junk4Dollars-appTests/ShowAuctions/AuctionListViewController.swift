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

    func testDataSourceIsSetAsExpected() {
        let controller = buildController()
        controller.viewDidLoad()
        XCTAssert(controller.auctionsDataSource === controller.auctionTableView.dataSource)
    }

    func testTableInitiallyHasOneSection() {
        let controller = buildController()
        controller.viewDidLoad()
        let sectionCount = controller.auctionTableView.numberOfSections
        XCTAssertEqual(1, sectionCount)
    }

    func testTableInitiallyHasOneSectionWithZeroRows() {
        let controller = buildController()
        controller.viewDidLoad()
        let sectionCount = controller.auctionTableView.numberOfSections
        XCTAssertEqual(1, sectionCount)
        let rowCount = controller.auctionTableView.numberOfRows(inSection: 0)
        XCTAssertEqual(0, rowCount)
    }
}
