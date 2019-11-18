//
//  JSONParsingTests.swift
//  Junk4Dollars-appTests
//
//  Created by John Riccardi on 11/12/19.
//  Copyright © 2019 John Riccardi. All rights reserved.
//

import Foundation
import XCTest
import Junk4Dollars_app

class JSONParsingTests: XCTestCase {
    func testDecodeApiResponse() {
        let testDictionary: Dictionary<String, Any> = [
            "foo": "bar",
            "baz": 100
        ]

        func asString(jsonDictionary: Dictionary<String, Any>) -> String {
          do {
            let data = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
            return String(data: data, encoding: String.Encoding.utf8) ?? ""
          } catch {
            return ""
          }
        }

        let stringifiedJson: Data? = asString(jsonDictionary: testDictionary).data(using: .utf8)

        let result = JSONParsing.decodeApiResponse(encodedJson: stringifiedJson!) as! Dictionary<String, Any>

        let fooResponse = result["foo"] as! String
        let bazResponse = result["baz"] as! Int

        XCTAssertEqual(testDictionary["foo"] as! String, fooResponse)
        XCTAssertEqual(testDictionary["baz"] as! Int, bazResponse)

    }

/* Need to make sure the createTimeObject gives us time back in UTC so we dont have to deal with this time zone issue */

//    func testCreateTimeObjectCreatesExpectedDateObject() {
//        let timeString = "2019-11-01T20:35:21.000Z"
//
//        let dateTime = JSONParsing.createTimeObject(stringTime: timeString)
//        let format = DateFormatter()
//        format.dateFormat = JSONParsing.formatString
//
//        let formattedDate = format.string(from: dateTime)
//        XCTAssertEqual(timeString, formattedDate)
//    }
}
