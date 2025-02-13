//
//  ThreatModel.swift
//  Icaro Assignment
//
//  Created by Jai Nijhawan on 12/02/25.
//

import Foundation

// MARK: - ThreatListModel
struct ThreatListModel: Codable {
    let queryStatus: String
    let urls: [ThreatModel]

    enum CodingKeys: String, CodingKey {
        case queryStatus = "query_status"
        case urls
    }
}

// MARK: - ThreatModel
struct ThreatModel: Codable {
    let id: Int
    let urlhausReference: String
    let url: String
    let urlStatus, host, dateAdded, threat: String
    let blacklists: Blacklists
    let reporter, larted: String
    let tags: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case urlhausReference = "urlhaus_reference"
        case url
        case urlStatus = "url_status"
        case host
        case dateAdded = "date_added"
        case threat, blacklists, reporter, larted, tags
    }
}

// MARK: - Blacklists
struct Blacklists: Codable {
    let spamhausDbl, surbl: String

    enum CodingKeys: String, CodingKey {
        case spamhausDbl = "spamhaus_dbl"
        case surbl
    }
}
