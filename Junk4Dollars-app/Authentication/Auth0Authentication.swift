import Auth0

class Auth0Authentication: Authentication    {
    var loggedIn = false

    func logOut(_ callback: @escaping () -> Void) {
        loggedIn = false
        callback()
    }

    func logIn(_ callback: @escaping (_ token: String) -> Void) {
        loggedIn = true
        callback("foo")
    }
}
