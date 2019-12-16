import XCTest
import Junk4Dollars_app

class AuctionListPresenterTests: XCTestCase {
    let fakeAuctions = [
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
        ],

    ]

    func createClientWithAuctions() -> HttpClient {
        let fakeClient = FakeHttpClient()
        fakeClient.stub(responseAsJson: fakeAuctions)
        return fakeClient
    }


    func testLoadAuctions_callsAuctionsLoaded() {
        AuthenticationDependencies.authentication = FakeAuthentication()
        let fakeClient = createClientWithAuctions()
        ApiDependencies.apiServices = ApiServices(client: fakeClient)
        let viewController = FakeAuctionListViewController()
        let presenter = AuctionListPresenter(view: viewController)

        presenter.loadAuctions()
        XCTAssertEqual(self.fakeAuctions.count, viewController.auctions.count)
    }
}
