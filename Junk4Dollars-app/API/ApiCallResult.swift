public enum ApiCallResult<T> {
    case success(data: T)
    case error(message: String)
}
