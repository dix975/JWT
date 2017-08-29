//
//  JWT.swift
//  EasyJWT
//
//  Created by Charles Billette on 2017-08-22.
//

import Foundation

public typealias Base64Signature = String

public enum JWTError: Error {
    case invalidSHA
    case invalidAlgorithm
}

public enum SHA: String {
    case sha256 = "256"
    case sha384 = "384"
    case sha512 = "512"
    
    init(string: String) throws {
        
        switch string {
            
        case "256": self = .sha256
        case "384": self = .sha384
        case "512": self = .sha512
        default: throw JWTError.invalidSHA
            
        }
    }
}

public enum Algorithm: Codable {
    
    case RSA(sha: SHA)
    case HMAC(sha: SHA)

    public init(from decoder: Decoder) throws {
        self = .RSA(sha: .sha256) //fix
    }
    
    public func encode(to encoder: Encoder) throws {
    }
    
    init(rawValue: String) throws {
        
        switch rawValue {
        case let alg where alg.hasPrefix("HS"):
            let sha = String(alg[String.Index(encodedOffset: 2)...])
            self = .HMAC(sha: try SHA(string: sha))
            break
        case let alg where alg.hasPrefix("RS"):
            let sha = String(alg[String.Index(encodedOffset: 2)...])
            self = .RSA(sha: try SHA(string: sha))
            break
        default: throw JWTError.invalidAlgorithm
            
        }
    }
    
    
    
    public func description() -> String {
        
        switch self {
        case .RSA(let sha):
            
            return "RS\(sha.rawValue)"
            
        case .HMAC(let sha):
            
            return "HS\(sha.rawValue)"
        }
    }
    
}

public struct Headers: Codable {
    
    let algorithm: Algorithm
    let type = "JWT"
    
    enum CodingKeys : String, CodingKey {
        case algorithm = "alg"
        case type = "typ"
    }
    
    
    init(algorithm: Algorithm) {
        self.algorithm = algorithm
    }
    
    func toJsonString() throws -> String? {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data = try encoder.encode(self)
        let jsonString = String(data: data, encoding: .utf8)
        
        return jsonString
    }
    
}
public struct Claims : Codable {
    
    let id: String?
    let issuer: String?
    let expiration: Date?
    let notBefore: Date?
    let issuedAt: Date?
    let subject: String?
    let audience: String?
    
    
    enum CodingKeys : String, CodingKey {
        case id = "jti"
        case issuer = "iss"
        case expiration = "exp"
        case notBefore = "nbf"
        case issuedAt = "iat"
        case subject = "sub"
        case audience = "aud"
    }
    
    init(
        withIssuer issuer: String? = nil,
        issuedAt: Date? = nil,
        id: String? = nil,
        notBefore: Date? = nil,
        expiration: Date? = nil,
        subject: String? = nil,
        audience: String? = nil
        ) {
        
        self.id = id
        self.issuer = issuer
        self.notBefore = notBefore
        self.issuedAt = issuedAt
        self.expiration = expiration
        self.subject = subject
        self.audience = audience
    }
    
    func toJsonString() throws -> String? {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        
        let data = try encoder.encode(self)
        let jsonString = String(data: data, encoding: .utf8)
        
        return jsonString
    }
}

public struct JWT {
    
    let headers: Headers
    let claims: Claims
    
    public init(withAlgorithm algorithm: Algorithm, claims: Claims) {
        self.headers = Headers(algorithm: algorithm)
        self.claims = claims
    }
    
    private func message() -> String {
        return "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9"
    }
    
    public func signature() throws -> Base64Signature {
        
        return try signature()
        
    }
    
    public func sign() throws -> Base64Signature {
        
//        let bytes = try self.headers.algorithm.signer().sign(
//            message: self.message()
//        )
//        
//        return Base64Signature(Base64.encode(data: Data(bytes: bytes)))
        return Base64Signature("fix")
    }
}
