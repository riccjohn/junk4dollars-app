import Junk4Dollars_app
import XCTest

class AuctionDetailsViewControllerTests: XCTestCase {
    var authentication: FakeAuthentication = FakeAuthentication()
    var apiClient: FakeHttpClient = FakeHttpClient()

    func testController_labelsAreInitiallyBlank() {
        AuthenticationDependencies.authentication = authentication
        ApiDependencies.apiServices = ApiServices(client: apiClient)

        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuctionDetailsViewController") as! AuctionDetailsViewController

        let _ = controller.view

        controller.viewDidLoad()
        XCTAssertEqual("", controller.auctionTitleLabel.text)
        XCTAssertEqual("", controller.auctionDescriptionLabel.text)
        XCTAssertEqual("", controller.auctionPriceLabel.text)
        XCTAssertEqual("", controller.auctionTimeRemainingLabel.text)
    }

    func testController_SetsLabelsWithAuctionData() {

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

        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuctionDetailsViewController") as! AuctionDetailsViewController

        let _ = controller.view

        controller.auctionId = 001
        controller.viewDidLoad()
        controller.viewWillAppear(true)

        let expectation = XCTestExpectation()
        DispatchQueue.main.async {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)

        XCTAssertEqual(fakeAuction["title"] as? String, controller.auctionTitleLabel.text)
        XCTAssertEqual(fakeAuction["description"] as? String, controller.auctionDescriptionLabel.text)
        XCTAssertEqual("$85.00", controller.auctionPriceLabel.text)
        XCTAssertEqual(fakeAuction["ends_at"] as? String, controller.auctionTimeRemainingLabel.text)
    }
}
