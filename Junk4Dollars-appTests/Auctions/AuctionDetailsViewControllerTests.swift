import Junk4Dollars_app
import XCTest

class AuctionDetailsViewControllerTests: XCTestCase {
    var authentication: FakeAuthentication = FakeAuthentication()
    var apiClient: FakeHttpClient = FakeHttpClient()

    let freshAuction: Dictionary<String, Any> = [
        "id": 001,
        "title": "Throne of Eldraine Booster Box",
        "description": "New",
        "starting_price": 8500,
        "ends_at": "2019-11-01T20:35:21.000Z",
        "created_at": "2019-11-18T20:25:58.247Z",
        "updated_at": "2019-11-18T20:25:58.247Z"
    ]

    let auctionWithBid: Dictionary<String, Any> = [
        "id": 1,
        "title": "Throne of Eldraine Booster Box",
        "description": "New: A brand-new, unused, unopened, undamaged item (including handmade items).",
        "starting_price": 8500,
        "ends_at": "2019-11-01T20:35:21.000Z",
        "created_at": "2020-01-02T20:16:23.221Z",
        "updated_at": "2020-01-02T20:16:23.221Z",
        "user_id": 1,
        "bid": [
            "id": 1,
            "price": 8699,
            "created_at": "2020-01-03T15:50:53.993Z",
            "updated_at": "2020-01-03T15:50:53.993Z",
            "user_id": 3,
            "auction_id": 1
        ]
    ]

    func createController() -> AuctionDetailsViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuctionDetailsViewController") as! AuctionDetailsViewController
        let _ = controller.view
        return controller
    }

    func stubWithFreshAuction() {
        apiClient.stub(responseAsJson: freshAuction)
        AuthenticationDependencies.authentication = authentication
        ApiDependencies.apiServices = ApiServices(client: apiClient)
    }

    func stubWithAuctionWithBid() {
        apiClient.stub(responseAsJson: auctionWithBid)
        AuthenticationDependencies.authentication = authentication
        ApiDependencies.apiServices = ApiServices(client: apiClient)
    }

    func createDummyExpectation() {
        let expectation = XCTestExpectation()
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testController_labelsAreInitiallyBlank() {
        let controller = createController()

        controller.viewDidLoad()
        XCTAssertEqual("", controller.auctionTitleLabel.text)
        XCTAssertEqual("", controller.auctionDescriptionLabel.text)
        XCTAssertEqual("", controller.auctionPriceLabel.text)
        XCTAssertEqual("", controller.auctionTimeRemainingLabel.text)
    }

    func testController_SetsLabelsWithAuctionData() {
        stubWithFreshAuction()

        let controller = createController()

        controller.auctionId = 001
        controller.viewDidLoad()
        controller.viewWillAppear(true)

        createDummyExpectation()

        XCTAssertEqual(freshAuction["title"] as? String, controller.auctionTitleLabel.text)
        XCTAssertEqual(freshAuction["description"] as? String, controller.auctionDescriptionLabel.text)
        XCTAssertEqual("$85.00", controller.auctionPriceLabel.text)

        XCTAssertEqual("11-01-2019 3:35 PM", controller.auctionTimeRemainingLabel.text)
    }

    func testController_whenAuctionHasBid_setsPriceLabel_toBidPrice() {
        stubWithAuctionWithBid()
        let controller = createController()

        controller.auctionId = 1
        controller.viewDidLoad()
        controller.viewWillAppear(true)

        createDummyExpectation()

        XCTAssertEqual("$86.99", controller.auctionPriceLabel.text)
    }

    func testSubmitBid_updatesAuctionPrice_whenSuccessful() {
        stubWithFreshAuction()

        let controller = createController()
        controller.auctionId = 1

        controller.viewDidLoad()
        controller.viewWillAppear(true)

        createDummyExpectation()

        // Check that price is initially set to the staritng_price
        XCTAssertEqual("$85.00", controller.auctionPriceLabel.text)

        stubWithAuctionWithBid()

        controller.bidPriceInput?.text = "90.99"
        controller.auctionId = 123
        controller.submitBid(UIButton())

        createDummyExpectation()
        XCTAssertEqual("$86.99", controller.auctionPriceLabel?.text)
    }
}
