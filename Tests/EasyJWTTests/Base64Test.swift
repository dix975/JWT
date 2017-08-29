//
//  Base64Test.swift
//  EasyJWTTests
//
//  Created by Charles Billette on 2017-08-24.
//

import XCTest
@testable import EasyJWT

class Base64Test: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test() {
        let encoded = Base64.encode(data: "test.data.1".data(using: .utf8)!)
        XCTAssertEqual(String(data:Base64.decode(string: encoded)!, encoding: .utf8), "test.data.1")
    }
    
}
