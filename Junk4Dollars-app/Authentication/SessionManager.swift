import Auth0

public class SessionManager {
    public let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
    }
}
