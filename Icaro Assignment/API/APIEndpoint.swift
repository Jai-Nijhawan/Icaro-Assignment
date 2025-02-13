//
//  APIEndpoint.swift
//  Icaro Assignment
//
//  Created by Jai Nijhawan on 12/02/25.
//

import Foundation

enum APIEndpoint {
    static let baseURL = URL(string: "https://urlhaus-api.abuse.ch/v1")!

    case recentThreats(limit: Int)

    var url: URL {
        switch self {
        case .recentThreats(let limit):
            return APIEndpoint.baseURL.appendingPathComponent("urls/recent/limit/\(limit)/")
        }
    }
}
