import Junk4Dollars_app
import XCTest

class AuctionDetailsViewControllerTests: XCTestCase {
    var authentication: FakeAuthentication = FakeAuthentication()
    var apiClient: FakeHttpClient = FakeHttpClient()

    func buildController() -> AuctionDetailsViewController  {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuctionDetailsViewController") as! AuctionDetailsViewController

        let _ = controller.view
        return controller
    }

    func waitForAsync() {
        let expectation = XCTestExpectation()
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func loadFakeAuction() -> Dictionary<String, Any> {
        let fakeAuction: Dictionary<String, Any> = [
            "id": 001,
            "title": "Throne of Eldraine Booster Box",
            "description": "New",
            "starting_price": 8500,
            "ends_at": "2019-11-01T20:35:21.000Z",
            "created_at": "2019-11-18T20:25:58.247Z",
            "updated_at": "2019-11-18T20:25:58.247Z"
        ]

        apiClient.stub(responseAsJson: fakeAuction)
        AuthenticationDependencies.authentication = authentication
        ApiDependencies.apiServices = ApiServices(client: apiClient)
        return fakeAuction
    }

    func testController_labelsAreInitiallyBlank() {
        AuthenticationDependencies.authentication = authentication
        ApiDependencies.apiServices = ApiServices(client: apiClient)

        let controller  = buildController()
        controller.viewDidLoad()

        XCTAssertEqual("", controller.auctionTitleLabel.text)
        XCTAssertEqual("", controller.auctionDescriptionLabel.text)
        XCTAssertEqual("", controller.auctionPriceLabel.text)
        XCTAssertEqual("", controller.auctionTimeRemainingLabel.text)
    }

    func testController_setsLabelWithAuctionData() {
        let controller = buildController()

        let auction = Auction(identifier: 1, title: "foo", description: "bar", startingPrice: 8500, endsAt: "2019-11-01T20:35:21.000Z")

        controller.auctionLoaded(auction: auction )
        waitForAsync()

        XCTAssertEqual(auction.title as? String, controller.auctionTitleLabel.text)
        XCTAssertEqual(auction.description as? String, controller.auctionDescriptionLabel.text)
        XCTAssertEqual("$85.00", controller.auctionPriceLabel.text)
        XCTAssertEqual("11-01-2019 3:35 PM", controller.auctionTimeRemainingLabel.text)
    }

    func testController_whenCreated_CallsPresenterAndLoadsAuction() {
        let fakeAuction = loadFakeAuction()
        let controller = buildController()
        controller.auctionId = 001

        controller.viewWillAppear(true)
        waitForAsync()

        XCTAssertEqual(fakeAuction["title"] as? String, controller.auctionTitleLabel.text)
    }
}
