//
//  HTTPBin.swift
//  GifWalletKitTests
//
//  Created by Jordi Serra i Font on 14/11/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import Foundation
import Deferred
@testable import GifWalletKit

/// Full-suite tests are courtesy of our good friends of HTTPBin

class HTTPBinAPIClient: APIClient {
    
    func fetchIPAddress() -> Task<HTTPBin.Responses.IP> {
        let request: Request<HTTPBin.Responses.IP> = requestForEndpoint(HTTPBin.API.ip)
        return perform(request)
    }
}

enum HTTPBin {
    enum Hosts: Environment {
        case production
        case development
        
        var baseURL: URL {
            switch self {
            case .production:
                return URL(string: "https://httpbin.org")!
            case .development:
                return URL(string: "https://dev.httpbin.org")!
            }
        }
    }
    
    enum API: Endpoint {
        case ip
        case orderPizza
        
        var path: String {
            switch self {
            case .orderPizza:
                return "/forms/post"
            case .ip:
                return "/ip"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .orderPizza:
                return .POST
            default:
                return .GET
            }
        }
    }
}

//MARK: Responses

extension HTTPBin {
    enum Responses {
        struct IP: Decodable {
            let origin: String
        }
    }
}
