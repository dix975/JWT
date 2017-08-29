import XCTest
import CryptoSwift
import RSAKey
import Axis

@testable import EasyJWT

struct HMACTest {
    let key: String
    let data: String
    let signature: String
    let sha: SHA
    
    init(withKey key: String, data: String, signature: String, sha: SHA){
        self.key = key
        self.data = data
        self.signature = signature
        self.sha = sha
    }
}

struct RSATest {
    let data: String
    let sha: SHA
    let function: RSAKey.Function
    
    init(data: String, sha: SHA, function: RSAKey.Function){
        self.data = data
        self.sha = sha
        self.function = function
    }
}

class EasyJWTTests: XCTestCase {
    
    func testHMAC() {
        
        for t in self.hmacTestVector {
            
            let s  = HMACSigner(withKey: t.key, sha: t.sha)
            XCTAssertEqual(try! Base64.encode(data: Data(bytes: s.sign(message: t.data))), t.signature)
            print(t.signature)
        }
        
    }
    
    func testRSASigner() {
        
        for t in self.rsaTestVector {
            
            do {
                
                let s  = RSASigner(withPrivateKey: pemPriv, publicKey: pemPub, sha: t.sha)
                let v = try RSAKey(pemPubString: pemPub)
                let signature = try s.sign(message: t.data)
                XCTAssert(try RSAKey.verify(t.data, Buffer(signature), v, t.function))
                
            }catch let error {
                
                print(error)
                XCTFail()
            }
        }
        
    }
    
    let hmacTestVector: [HMACTest] = [
        HMACTest(
            withKey: "secret",
            data: "eyJhbGciOiJINTEyIiwidHlwIjoiSldUIn0.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9",
            signature: "gXDKeDQ9_DWdgjAqQDZfYryASV7ao5aSOcROTKSjpWQ",
            sha: .sha256
        ),
        HMACTest(
            withKey: "secret",
            data: "message",
            signature: "i19IcCmVwVmMVz2x4hhmqbgl1KeU0WnXBgoDYFeWNgs",
            sha: .sha256
        ),
        HMACTest(
            withKey: "secret",
            data: "message",
            signature: "rQ706A2kJ7KjPURXyXK_dZ9Qdm-7ZlaQ1Qt8s43VIX21Wck-p8vuSOKuGltKr9NL",
            sha: .sha384
        ),
        HMACTest(
            withKey: "secret",
            data: "message",
            signature: "G7pYfHMO7box9Tq7C2ylieCd5OiU7kVeYUCAc5l1mtqvoGnux8AWR7sXPcsX9V0ir0mhgHG3SMXC7df3qCnGMg",
            sha: .sha512
        ),
        
        ]
    
    let rsaTestVector: [RSATest] = [
        RSATest(
            data: "message",
            sha: .sha256,
            function: RSAKey.Function.sha256
        ),
        RSATest(
            data: "message",
            sha: .sha384,
            function: RSAKey.Function.sha384
        ),
        RSATest(
            data: "message",
            sha: .sha512,
            function: RSAKey.Function.sha512
        ),
        
        ]
    
    //    static var allTests = [
    //        ("testExample", testExample),
    //    ]
    
    let pemPriv = "-----BEGIN PRIVATE KEY-----\n"
        + "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCfS9UqY3wW6Ncp\n"
        + "73XmKiUaEKHQ2YsrACoHcLjF1tSL4KZCGAOfkC4m6zVtGVvnuGKRGtcK4NRVmUY+\n"
        + "gT4kLixA8SujJ8ZJGmeCCTnbk3R8IQbqhOcZawguaDrY6+t5zLV3/YzxrlazgeXJ\n"
        + "HjSXuo7Q3HpachUCUQPqOm2R4rwfX3qCSWu6M4PRbTPB+8WIewlet0WPoNnuUUTv\n"
        + "hKBDHXAX8sUWBZ3CZ4UCysTJp3KsDITwKHCk/asXHOi0rAi0WucN58DdMEZ2wGuw\n"
        + "e3wnwzTbhSaQn6MDNlR0j7K1ZjMQ17dez4Be+La9w2gadJvezAcX2vODQFjrVpxg\n"
        + "9Zo5WEerAgMBAAECggEADnC8aTRNinIfFzEa+ft2E4/Qa3NdF0/Tf4srZNvdtrRt\n"
        + "ve4ZXfyfAm4uEK7M0wu2+7p4JgdNmFjlskLbFEKPRm/WadrwMa5QFcyqTwpl8962\n"
        + "lsnnfTljq3lNZF62oPr6tF7qyPnp6CntX7b6Q4ro6WwjN1HCL8ySU0hqqF/qd9l2\n"
        + "R/3kewsR4pGYNi4oY3GtRO0ICMZCAAi0v1Tdet8Me1NFGM7sSfcmKV7v9RI5/7lt\n"
        + "z8EOfJbUUBDp5I3GL/wGDa/tjoGOjRDg6iirdBsiEFGIWJXX9hZT8FVLgt+Ai8MB\n"
        + "l+OKR7QOyI7KMm8FtD3xsq+bsEvt3OhDLhGcNEqeMQKBgQDSUk81e6v4TmtC3sbr\n"
        + "elVScI4ZWrs1gyLt9/9xyrK0Kr2ONfk9G6Z4PvyaWAPBHmf0xnsVdoUzcVWhrg42\n"
        + "bJvTYvMNjMxuCykzRhXy9OWNdPM75O0zozBHc8yvq9fIWsNiGXbr3Nw76d+0PRYb\n"
        + "183+Urc5dsH5GvVZ7aKl6xZMgwKBgQDB5I/NJkn4zfbVRrq1iCImginSHO0bSuA5\n"
        + "7B40IGdQkoNnvH93wKz22kBMUAVgX4SGHWbvpKdlo+pw47pFr8zzRrp5jeAHiMmY\n"
        + "CBUPTj78316nULmbi7RvvNdbc5nnZ0lRp+NS6gfcksFTuG5k/42HIIVlgnLRtXxy\n"
        + "IyRRmcJ/uQKBgQDA8zovutG971N/+ZlMluKHyzLSF+b/5Nq6rnXvEyJ3H27fdKy/\n"
        + "XwqN7lsXzf9DwH1mlmB9BEqXMzZ4KZJoY6Nhfrm0iKNToXGe1IF2by3ZZJ1xKUhj\n"
        + "wyabpqT11RUVfg8ZhHsRT4HMhXbxh8ksqgMVexUU5tp1ikHkypoY1V+TuQKBgGYW\n"
        + "/WxsS6iYce3sNuTcT/bstC5wkpu7OgLlgyW5JgzziAL36jnYlnnHgvFrdNlAkdu3\n"
        + "4XouvQE0ZH2aOnr0zLoPNKJKBHqTGGpXXxdXAK1Ow1zfkUsILTJkQRRi8tc3uBAp\n"
        + "kPUYSplmICr/wgil0hQjGHnRTLmEkIjcXgQlLJbpAoGAamlIz3cV12/72zVtF/52\n"
        + "O+5uZ0/4R7FQ1QpY48hkEgjHjMPqqJvOJHfkfyINliHaJ7aernG/qaP+CSukOn5l\n"
        + "3+Kov/ig6G9jlUVijurjLqeneVBVocX90fC65eBDL8H8tEcxfrp6/Jb5iloYtcdB\n"
        + "a6BNdwh9hHOXQ47q28/pjsc=\n"
        + "-----END PRIVATE KEY-----"
    
    let pemPub = "-----BEGIN PUBLIC KEY-----\n"
        + "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAn0vVKmN8FujXKe915iol\n"
        + "GhCh0NmLKwAqB3C4xdbUi+CmQhgDn5AuJus1bRlb57hikRrXCuDUVZlGPoE+JC4s\n"
        + "QPEroyfGSRpnggk525N0fCEG6oTnGWsILmg62Ovrecy1d/2M8a5Ws4HlyR40l7qO\n"
        + "0Nx6WnIVAlED6jptkeK8H196gklrujOD0W0zwfvFiHsJXrdFj6DZ7lFE74SgQx1w\n"
        + "F/LFFgWdwmeFAsrEyadyrAyE8ChwpP2rFxzotKwItFrnDefA3TBGdsBrsHt8J8M0\n"
        + "24UmkJ+jAzZUdI+ytWYzENe3Xs+AXvi2vcNoGnSb3swHF9rzg0BY61acYPWaOVhH\n"
        + "qwIDAQAB\n"
        + "-----END PUBLIC KEY-----"

    
}
