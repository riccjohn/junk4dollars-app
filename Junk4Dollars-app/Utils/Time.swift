import Foundation

public struct Time {
    var utc: String

    public init(utc: String) {
        self.utc = utc
    }

    public func local() -> String? {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"


        guard let date = dateFormatter.date(from: self.utc) else {
            return nil
        }

        dateFormatter.dateFormat = "MM-dd-yyyy h:mm a"
        dateFormatter.locale = tempLocale

        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
