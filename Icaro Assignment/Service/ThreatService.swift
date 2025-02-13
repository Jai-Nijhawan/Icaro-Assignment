//
//  ThreatService.swift
//  Icaro Assignment
//
//  Created by Jai Nijhawan on 12/02/25.
//

import Foundation

protocol ThreatServiceProtocol {
    func fetchThreats(limit: Int, completion: @escaping (Result<ThreatListModel, NetworkError>) -> Void)
}

class ThreatService: ThreatServiceProtocol {
    func fetchThreats(limit: Int, completion: @escaping (Result<ThreatListModel, NetworkError>) -> Void) {
        let url = APIEndpoint.recentThreats(limit: limit).url
        NetworkManager.shared.fetchData(from: url, completion: completion)
    }
}
