//
//  ThreatListViewController.swift
//  Icaro Assignment
//
//  Created by Jai Nijhawan on 12/02/25.
//

import UIKit

class ThreatListViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: ThreatViewModelProtocol

    // MARK: - Initializer
    init(viewModel: ThreatViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchThreats(limit: nil)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
    }
}

// MARK: - ThreatViewModelDelegate
extension ThreatListViewController: ThreatViewModelDelegate {
    func didUpdateThreats() {
        print("Threat data updated successfully in ViewController.")
    }

    func didFail(with error: NetworkError) {
        print("Failed to fetch threats: \(error)")
    }
}
