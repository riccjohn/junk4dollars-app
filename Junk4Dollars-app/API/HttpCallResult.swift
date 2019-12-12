public enum HttpCallResult<T> {
    case success(data: T)
    case error(message: String)
}
