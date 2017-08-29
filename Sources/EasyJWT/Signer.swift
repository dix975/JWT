//
//  Signer.swift
//  EasyJWT
//
//  Created by Charles Billette on 2017-08-22.
//

import Foundation

public protocol Signer {
    
    func sign(message: String) throws -> [UInt8]
    
}
