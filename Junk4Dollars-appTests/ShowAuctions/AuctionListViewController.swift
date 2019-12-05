import XCTest
import UIKit
import Junk4Dollars_app

class AuctionListViewControllerTests: XCTestCase {
    var authentication = FakeAuthentication()

    func buildController() -> AuctionListViewController {
        AuthenticationDependencies.authentication = authentication
        let controller: AuctionListViewController! = AuctionListViewController()
        controller.logInOutButton = UIBarButtonItem()
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

    func testLogInOut_whenLoggedOut_changesTitleTo_LogOut_and_logsUserIn() {
        let controller = buildController()
        authentication.logOut() {}

        controller.logInOut(controller.logInOutButton)

        XCTAssertEqual(true, authentication.loggedIn)
        XCTAssertEqual("Log Out", controller.logInOutButton.title)
    }

    func testLogInOut_whenLoggedIn_changesTitleTo_LogIn_and_logsUserOut() {
        let controller = buildController()
        authentication.logIn() {token in
        }

        controller.logInOut(controller.logInOutButton)

        XCTAssertEqual(false, authentication.loggedIn)
        XCTAssertEqual("Log In", controller.logInOutButton.title)
    }
}
