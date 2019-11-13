//
//  QueryAPI.swift
//  Junk4Dollars-app
//
//  Created by John Riccardi on 11/13/19.
//  Copyright © 2019 John Riccardi. All rights reserved.
//

import Foundation

class QueryAPI {
    public static func makeApiCall(endpoint: String, whatToDoWithResponseData: @escaping (Data, URLResponse?, Error?) -> Void) -> Void {
        let url = URL(string: endpoint)!
        let request: URLRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            // relies on error
            if let error = error {
                print("ERROR: \(error)")
            }

            guard let data = data else { return }

            whatToDoWithResponseData(data, response, error)
        }

        task.resume()
    }
}
