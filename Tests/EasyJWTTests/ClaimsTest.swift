//
//  ClaimsTest.swift
//  EasyJWTTests
//
//  Created by Charles Billette on 2017-08-24.
//

import XCTest
@testable import EasyJWT

class ClaimsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let s = try! Claims().toJsonString()!
        XCTAssertEqual(s,
                       """
{

}
"""
        )
    }
    
    func testFull() {
        
        let date = Date()
        let claims = Claims(
            withIssuer: "issuer.1",
            issuedAt: date,
            id: "id.1",
            notBefore: date.addingTimeInterval(-1),
            expiration: date.addingTimeInterval(1),
            subject: "subject.1",
            audience: "audience.1"
            
        )
        
        XCTAssertEqual(claims.issuer, "issuer.1")
        XCTAssertEqual(claims.issuedAt, date)
        XCTAssertEqual(claims.id, "id.1")
        XCTAssertEqual(claims.notBefore, date.addingTimeInterval(-1))
        XCTAssertEqual(claims.expiration, date.addingTimeInterval(1))
        XCTAssertEqual(claims.subject, "subject.1")
        XCTAssertEqual(claims.audience, "audience.1")
        
        do {
            
            let jsonString = try claims.toJsonString()
            print(jsonString!)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedClaims = try decoder.decode(Claims.self, from: jsonString!.data(using: .utf8)!)
            
            XCTAssertEqual(decodedClaims.issuer, "issuer.1")
            XCTAssertEqual(decodedClaims.issuedAt?.description, date.description)
            XCTAssertEqual(decodedClaims.id, "id.1")
            XCTAssertEqual(decodedClaims.notBefore?.description, date.addingTimeInterval(-1).description)
            XCTAssertEqual(decodedClaims.expiration?.description, date.addingTimeInterval(1).description)
            XCTAssertEqual(decodedClaims.subject, "subject.1")
            XCTAssertEqual(decodedClaims.audience, "audience.1")
            
        } catch let error {
            
            print(error)
            XCTFail()
            
        }

    }
    
}
