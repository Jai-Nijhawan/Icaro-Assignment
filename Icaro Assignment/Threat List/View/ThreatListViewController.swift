//
//  ThreatListViewController.swift
//  Icaro Assignment
//
//  Created by Jai Nijhawan on 12/02/25.
//

import UIKit

class ThreatListViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: ThreatViewModelProtocol

    // MARK: - UI Elements
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fetching threats..."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Initializer
    init(viewModel: ThreatViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchThreats()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(activityIndicator)
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            statusLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Fetch Data
    private func fetchThreats() {
        showLoadingState()
        //MARK: - Delay added to show Loading State
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
            self?.viewModel.fetchThreats()
        })
    }

    // MARK: - UI Handlers
    private func showLoadingState() {
        activityIndicator.startAnimating()
        statusLabel.text = "Fetching threats..."
        statusLabel.isHidden = false
    }

    private func showSuccessState() {
        activityIndicator.stopAnimating()
        statusLabel.isHidden = true
    }

    private func showFailureState() {
        activityIndicator.stopAnimating()
        statusLabel.text = "Failed to fetch threats."
        statusLabel.textColor = .red
    }
}

// MARK: - ThreatViewModelDelegate
extension ThreatListViewController: ThreatViewModelDelegate {
    func didUpdateThreats() {
        print("Threat data updated successfully in ViewController.")
        showSuccessState()
    }

    func didFail(with error: NetworkError) {
        print("Failed to fetch threats: \(error)")
        showFailureState()
    }
}
