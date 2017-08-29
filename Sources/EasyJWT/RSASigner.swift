//
// Created by Charles Billette on 2017-08-23.
//

import Foundation
import RSAKey

class RSASigner: Signer {
    let privateKey: String
    let publicKey: String
    let sha: SHA
    
    init(withPrivateKey privateKey: String, publicKey: String, sha: SHA) {
        
        self.privateKey = privateKey
        self.publicKey = publicKey
        self.sha = sha
        
    }
    
    func sign(message: String) throws -> [UInt8] {
        
        let keySign = try RSAKey(pemPrivString: self.privateKey)
        return try keySign.sign(message, self.function()).bytes
        
    }
    
    private func function() -> RSAKey.Function {
        
        switch self.sha {
        case .sha256:
            return RSAKey.Function.sha256
        case .sha384:
            return RSAKey.Function.sha384
        case .sha512:
            return RSAKey.Function.sha512
        }
        
    }
}
