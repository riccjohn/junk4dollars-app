import Auth0

class Auth0Authentication: Authentication {
    public var loggedIn = false
    public let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    let APIIdentifier = "junk4dollars"

    public func logOut(_ callback: @escaping () -> Void) {
        Auth0
        .webAuth()
        .clearSession(federated:false) {
            switch $0 {
                case true:
                    self.loggedIn = false
                    callback()
                case false:
                   print("Error logging out")
            }
        }
    }

    public func logIn( _ callback: @escaping (_ token: String) -> Void) {
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience(APIIdentifier)
            .start {
                switch $0 {
                case .failure(let error):
                    print("Error: \(error)")
                case .success(let credentials):
                    self.credentialsManager.store(credentials: credentials)
                    self.loggedIn = true
                    callback(credentials.accessToken!)
                }
        }
    }

    public func getUserInfo(_ accessToken: String) -> Void {
        Auth0
        .authentication()
        .userInfo(withAccessToken: accessToken)
        .start { result in
            switch(result) {
            case .success(let profile):
                print("PROFILE ID ==>", profile.sub)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

}
