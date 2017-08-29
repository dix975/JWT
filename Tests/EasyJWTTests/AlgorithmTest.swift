//
//  AlgorithmTest.swift
//  EasyJWTTests
//
//  Created by Charles Billette on 2017-08-24.
//

import XCTest
@testable import EasyJWT

class AlgorithmTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    let testInitVector = [
        [
            "raw": "HS256",
            "algo": Algorithm.HMAC(sha: .sha256)
        ],
        [
            "raw": "HS384",
            "algo": Algorithm.HMAC(sha: .sha384)
        ],

        [
            "raw": "HS512",
            "algo": Algorithm.HMAC(sha: .sha512)
        ],
        [
            "raw": "RS256",
            "algo": Algorithm.RSA(sha: .sha256)
        ],
        [
            "raw": "RS384",
            "algo": Algorithm.RSA(sha: .sha384)
        ],

        [
            "raw": "RS512",
            "algo": Algorithm.RSA(sha: .sha512)
        ],
    ]

    func testInit() {
        
        do {

            for t in testInitVector {
                let algo = try Algorithm(rawValue: t["raw"] as! String)
                XCTAssertEqual(algo.description(), (t["algo"] as! Algorithm).description())
            }

        } catch let error {
            print(error)
            XCTFail()
        }
    }

    func testInitBadSha() {

        XCTAssertThrowsError(
            try Algorithm(rawValue: "HS2256")
        )

    }
    func testInitBadAlgo() {

        XCTAssertThrowsError(
                try Algorithm(rawValue: "TT256")
        )

    }

    
    func testDescription() {
        
        let hmac = Algorithm.HMAC(sha: .sha256)
        XCTAssertEqual(hmac.description(), "HS256")
        
    }
    
}
