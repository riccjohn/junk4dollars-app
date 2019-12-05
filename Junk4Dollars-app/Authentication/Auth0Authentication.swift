import Auth0

class Auth0Authentication: Authentication    {
    public var loggedIn = false
    let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
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

    public func logIn(_ callback: @escaping () -> Void) {
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
                    callback()
                }
        }
    }

//    public func getAccessToken(_ callback: (_ token: String) -> Void) {
//        credentialsManager.credentials { error, credentials in
//            guard error == nil, let credentials = credentials else {
//                print("ERROR!", error)
//                return
//            }
//
//            if let accessToken = credentials.accessToken {
//                callback(accessToken)
//            }
//        }
//    }
}
