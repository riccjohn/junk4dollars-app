import XCTest
import UIKit
import Junk4Dollars_app

class AuctionListViewControllerTests: XCTestCase {
    var authentication: FakeAuthentication = FakeAuthentication()
    var apiClient: FakeHttpClient = FakeHttpClient()

    func buildController() -> AuctionListViewController {
        authentication = FakeAuthentication()
        apiClient = FakeHttpClient()
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

    func testTableHasNumOfRows_equalToNumAuctions() {
        let controller = buildController()
        let fakeAuctions: [Dictionary<String, Any>] = [
            [
                "id": 001,
                "title": "Throne of Eldraine Booster Box",
                "description": "New",
                "starting_price": 8500,
                "ends_at": "2019-11-01T20:35:21.000Z",
                "created_at": "2019-11-18T20:25:58.247Z",
                "updated_at": "2019-11-18T20:25:58.247Z"
            ],
            [
                "id": 002,
                "title": "M20 Booster Box",
                "description": "New",
                "starting_price": 8200,
                "ends_at": "2019-11-01T20:35:21.000Z",
                "created_at": "2019-11-18T20:25:58.247Z",
                "updated_at": "2019-11-18T20:25:58.247Z"
            ]
        ]
        apiClient.stub(responseAsJson: fakeAuctions)
        controller.viewDidLoad()
        controller.viewWillAppear(true)
        let rowCount = controller.auctionTableView.numberOfRows(inSection: 0)
        XCTAssertEqual(fakeAuctions.count, rowCount)
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

    func testLogInOut_whenLoggedIn_resetsWelcomeMessage() {
        let controller = buildController()
        apiClient.stub(responseAsJson: ["id": 1, "name": "John"])
        authentication.logIn() {

        }
        controller.logInOut(controller.logInOutButton)

        let expectation = XCTestExpectation()
        DispatchQueue.main.async {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)

        XCTAssertEqual(false, authentication.loggedIn)
        XCTAssertEqual("", controller.welcomeLabel?.text)
    }
}
