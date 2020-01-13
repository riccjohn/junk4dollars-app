public class AuctionDetailsPresenter {
    public let view: AuctionDetailsView
    let apiServices = ApiDependencies.apiServices

    public init(view: AuctionDetailsView) {
        self.view = view
    }

    public func loadAuction(id: Int) -> Void {
        self.apiServices.getAuction(id: id) { result in
            switch result {
                case .success(let auction):
                    self.view.auctionLoaded(auction: auction)
                case .error(let message):
                    print("An error occurred: \(message)")
            }
        }
    }

    public func submitBid(auctionId: Int, price: Int) -> Void {
        self.apiServices.submitBid(auctionId: auctionId, price: price) { result in
            switch result {
                case .success(let auction):
                    self.view.auctionLoaded(auction: auction)
                case .error(let message):
                    print("An error occurred: \(message)")
            }
        }
    }
}
