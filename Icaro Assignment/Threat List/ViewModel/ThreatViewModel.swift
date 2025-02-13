//
//  ThreatViewModel.swift
//  Icaro Assignment
//
//  Created by Jai Nijhawan on 12/02/25.
//

import Foundation

protocol ThreatViewModelDelegate: AnyObject {
    func didUpdateThreats()
    func didFail(with error: NetworkError)
}

protocol ThreatViewModelProtocol {
    func fetchThreats(limit: Int?)
}

final class ThreatViewModel: ThreatViewModelProtocol {
    
    // MARK: - Properties
    private let threatService: ThreatServiceProtocol
    private let threatLimit: Int
    weak var delegate: ThreatViewModelDelegate?
    
    private(set) var threats: [ThreatModel] = []
    
    // MARK: - Initializer
    init(threatService: ThreatServiceProtocol, threatLimit: Int = 10) {
        self.threatService = threatService
        self.threatLimit = threatLimit
    }
    
    // MARK: - Public Methods
    func fetchThreats(limit: Int? = nil) {
        let fetchLimit = limit ?? threatLimit
        threatService.fetchThreats(limit: fetchLimit) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleFetchResult(result)
            }
        }
    }
    
    // MARK: - Private Methods
    private func handleFetchResult(_ result: Result<ThreatListModel, NetworkError>) {
        switch result {
        case .success(let threatListModel):
            self.threats = threatListModel.urls
            delegate?.didUpdateThreats()
            
            // Print the response data
            print("Fetched \(threatListModel.urls.count) threats:")
            for threat in threatListModel.urls {
                print("- \(threat.url) | Status: \(threat.urlStatus) | Threat: \(threat.threat)")
            }
            
        case .failure(let error):
            delegate?.didFail(with: error)
            print("Error fetching threats: \(error)")
        }
    }
}
