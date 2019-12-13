public class AuctionListPresenter {
    public let view: AuctionListView
    let apiServices = ApiDependencies.apiServices

    public init(view: AuctionListView) {
        self.view = view
    }

    public func loadAuctions() -> Void {
        self.apiServices.getAllAuctions { result in
            switch result {
                case .success(let auctions):
                    self.view.refresh(auctions: auctions)
                case .error(let message):
                    print("An error  occurred: \(message)")
            }
        }
    }
}
