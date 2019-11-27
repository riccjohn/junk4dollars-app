import Junk4Dollars_app

class FakeAuthentication: Authentication {
    var loggedIn = false

    func logIn(_ callback: @escaping() -> Void) {
        loggedIn = true
    }

    func logOut(_ callback: @escaping() -> Void) {
        loggedIn = false
    }
}
