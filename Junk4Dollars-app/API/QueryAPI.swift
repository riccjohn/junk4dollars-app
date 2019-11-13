//
//  QueryAPI.swift
//  Junk4Dollars-app
//
//  Created by John Riccardi on 11/13/19.
//  Copyright © 2019 John Riccardi. All rights reserved.
//

import Foundation

public struct ApiQueryError: Error {
    public enum ErrorKind {
        case
            noData
    }

    public let kind: ErrorKind
}

public protocol APICallable {
    func makeApiCall(endpoint: String, whatToDoWithResponseData: @escaping (Data?, URLResponse?, Error?) -> Void) -> Void
}

public class QueryAPI: APICallable {
    public func makeApiCall(endpoint: String, whatToDoWithResponseData: @escaping (Data?, URLResponse?, Error?) -> Void) -> Void {
        let url = URL(string: endpoint)!
        let request: URLRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                print("ERROR: \(error)")
            }

            guard let data = data else { return }

            whatToDoWithResponseData(data, response, error)
        }

        task.resume()
    }
}

public class MockQueryAPI: APICallable {
    let data: Data
    let response: URLResponse?
    let error: Error?

    public init() {
        data = Data()
        response = Optional<URLResponse>(nilLiteral: ())
        error = Optional<Error>(nilLiteral: ())
    }

    public func makeApiCall(endpoint: String, whatToDoWithResponseData: @escaping (Data?, URLResponse?, Error?) -> Void) -> Void {
        whatToDoWithResponseData(self.data, self.response, self.error)
    }
}
