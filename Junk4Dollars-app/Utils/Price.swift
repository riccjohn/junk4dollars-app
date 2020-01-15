import Foundation

public struct Price {
  var inCents: Int

    public init(inCents: Int) {
        self.inCents = inCents
    }

  public func inDollars() -> String {
    let number = Double(inCents) / Double(100)

    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    return numberFormatter.string(from: NSNumber(value:number))!
  }
}
