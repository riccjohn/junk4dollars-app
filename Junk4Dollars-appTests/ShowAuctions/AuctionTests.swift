//
//  AuctionTests.swift
//  Junk4Dollars-appTests
//
//  Created by John Riccardi on 11/12/19.
//  Copyright © 2019 John Riccardi. All rights reserved.
//

import Foundation
import XCTest
import Junk4Dollars_app

class AuctionTests: XCTestCase {
    func testAuctionFromParsesCorrectly() {
        let id = 1
        let title = "Title here"
        let description = "Description here"
        let startingPrice = 1000
        let endsAt = "2019-11-01T20:35:21.000Z"

        let testDictionary = [
            "id": id,
            "title": title,
            "description": description,
            "starting_price": startingPrice,
            "ends_at": endsAt
            ] as [String : Any]

        let auction = Auction.from(json: testDictionary)
        XCTAssertEqual(id, auction.identifier)
        XCTAssertEqual(title, auction.title)
        XCTAssertEqual(description, auction.description)
        XCTAssertEqual(startingPrice, auction.startingPrice)
        XCTAssertEqual(JSONParsing.createTimeObject(stringTime: endsAt), auction.endsAt)
    }
}
