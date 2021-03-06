public protocol Authentication {
    var loggedIn: Bool { get }
    func logOut(_ callback: @escaping() -> Void)
    func logIn(_ callback: @escaping() -> Void)
    func getAccessToken(_ callback: @escaping(_ accessToken: String) -> Void)
}
