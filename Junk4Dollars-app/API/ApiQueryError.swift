public struct ApiQueryError: Error {
    public enum ErrorKind {
        case noData
    }

    public let kind: ErrorKind
}
