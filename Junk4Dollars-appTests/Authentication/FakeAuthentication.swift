import Junk4Dollars_app

class FakeAuthentication: Authentication {
    var loggedIn = false

    func logOut(_ callback: @escaping () -> Void) {
        loggedIn = false
        callback()
    }

    func logIn(_ callback: @escaping () -> Void) {
        loggedIn = true
        callback()
    }
}
