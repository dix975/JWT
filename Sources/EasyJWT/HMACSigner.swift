//
//  HMACSigner.swift
//  EasyJWT
//
//  Created by Charles Billette on 2017-08-22.
//

import Foundation
import CryptoSwift

class HMACSigner: Signer {
    
    let sha: SHA
    let key: String
    
    init(withKey key: String, sha: SHA) {
        self.sha = sha
        self.key = key
    }
    
    func sign(message: String) throws -> [UInt8] {
        
        return try HMAC(key: self.key, variant: variant(sha: self.sha)).authenticate([UInt8](message.utf8))
    }
    
    func variant(sha: SHA) -> HMAC.Variant {
        switch sha {
        case .sha256:
            return .sha256
        case .sha384:
            return .sha384
        case .sha512:
            return .sha512
        }
    }
}
