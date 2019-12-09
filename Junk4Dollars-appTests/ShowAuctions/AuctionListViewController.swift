import XCTest
import UIKit
import Junk4Dollars_app

class AuctionListViewControllerTests: XCTestCase {
    var authentication: FakeAuthentication = FakeAuthentication()
    var apiClient: FakeApiClient = FakeApiClient()

    func buildController() -> AuctionListViewController {
        authentication = FakeAuthentication()
        apiClient = FakeApiClient()
        AuthenticationDependencies.authentication = authentication
        ApiDependencies.apiServices = ApiServices(client: apiClient)
        let controller: AuctionListViewController! = AuctionListViewController()
        controller.logInOutButton = UIBarButtonItem()
        let tableView = UITableView()
        controller.auctionTableView = tableView
        controller.welcomeLabel = UILabel()
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
        apiClient.stub(responseAsJson: ["id": 1, "name": "John"])

        authentication.logOut() {}
        controller.logInOut(controller.logInOutButton)

        let expectation = XCTestExpectation()
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(true, authentication.loggedIn)
        XCTAssertEqual("Log Out", controller.logInOutButton.title)
    }

    func testLogInOut_whenLoggedOut_LogsUserIn_andDisplaysWelcomeMessage() {
        let controller = buildController()
        apiClient.stub(responseAsJson: ["id": 1, "name": "John"])

        authentication.logOut() {}
        controller.logInOut(controller.logInOutButton)

        let expectation = XCTestExpectation()
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(true, authentication.loggedIn)
        XCTAssertEqual("Welcome, John!", controller.welcomeLabel?.text)
    }

    func testLogInOut_whenLoggedIn_changesTitleTo_LogIn_and_logsUserOut() {
        let controller = buildController()
        authentication.logIn() {
        }

        controller.logInOut(controller.logInOutButton)

        XCTAssertEqual(false, authentication.loggedIn)
        XCTAssertEqual("Log In", controller.logInOutButton.title)
    }

    // add assertion that logging out changes title

    // add assertion that logging in with auth0 but getting a 401 from Rails does not log you in / does not change "logInOut" title
}
