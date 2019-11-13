//
//  JSONParsing.swift
//  Junk4Dollars-app
//
//  Created by John Riccardi on 11/12/19.
//  Copyright © 2019 John Riccardi. All rights reserved.
//

import Foundation

public class JSONParsing {
    public static let formatString = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    public static func createTimeObject(stringTime: String) -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = formatString
        return dateFormatterGet.date(from: stringTime)!
    }

    public static func decodeAPIResponse(encodedJson: Data) -> Any {
        return try! JSONSerialization.jsonObject(with: encodedJson)
    }
}
