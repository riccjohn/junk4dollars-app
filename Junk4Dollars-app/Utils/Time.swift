import Foundation

public struct Time {
    var utc: String

    public init(utc: String) {
        self.utc = utc
    }

    public static func parseDateFrom(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        guard let date = dateFormatter.date(from: string) else {
            return nil
        }
        return date
    }

    public static func format(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy h:mm a"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
