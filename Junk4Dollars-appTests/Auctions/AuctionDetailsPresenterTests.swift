import XCTest
import Junk4Dollars_app

class AuctionDetailsPresenterTests: XCTestCase {

    let fakeAuction: Dictionary<String, Any> = [
        "id": 123,
        "title": "Throne of Eldraine Booster Box",
        "description": "New",
        "starting_price": 8500,
        "ends_at": "2019-11-01T20:35:21.000Z",
        "created_at": "2019-11-18T20:25:58.247Z",
        "updated_at": "2019-11-18T20:25:58.247Z"
    ]

    func createClientWithAuction() -> HttpClient {
        let fakeClient = FakeHttpClient()
        fakeClient.stub(responseAsJson: fakeAuction)
        return fakeClient
    }

    func testLoadAuction_callsAuctionLoaded() {
        AuthenticationDependencies.authentication = FakeAuthentication()
        let fakeClient = createClientWithAuction()
        ApiDependencies.apiServices = ApiServices(client: fakeClient)

        let viewController = FakeAuctionDetailsView()
        let presenter = AuctionDetailsPresenter(view: viewController)

        presenter.loadAuction(id: 123)
        XCTAssertNotNil(viewController.auction)
        XCTAssertEqual(fakeAuction["id"] as? Int, viewController.auction?.identifier)
    }

}
