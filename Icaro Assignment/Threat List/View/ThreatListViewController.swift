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
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "App Safety"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ThreatCell.self, forCellReuseIdentifier: ThreatCell.identifier)
        tableView.isHidden = true  // Initially hidden until data is loaded
        return tableView
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
        
        view.addSubview(backButton)
        view.addSubview(headerLabel)
        view.addSubview(activityIndicator)
        view.addSubview(statusLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            headerLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            
            statusLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Fetch Data
    private func fetchThreats() {
        showLoadingState()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in  // 3-second delay for testing
            self?.viewModel.fetchThreats()
        }
    }
    
    // MARK: - UI Handlers
    private func showLoadingState() {
        activityIndicator.startAnimating()
        statusLabel.text = "Fetching threats..."
        statusLabel.isHidden = false
        tableView.isHidden = true
    }
    
    private func showSuccessState() {
        activityIndicator.stopAnimating()
        statusLabel.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    private func showFailureState() {
        activityIndicator.stopAnimating()
        statusLabel.text = "Failed to fetch threats."
        statusLabel.textColor = .red
        tableView.isHidden = true
    }
    
    // MARK: - Button Actions
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ThreatListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2  // Section 1: Static Cell, Section 2: Dynamic Threats
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.threats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "infoCell")
            cell.textLabel?.text = "Threat Data Overview"
            cell.detailTextLabel?.text = "This list contains recent malware threats."
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ThreatCell.identifier, for: indexPath) as? ThreatCell else {
                return UITableViewCell()
            }
            let threat = viewModel.threats[indexPath.row]
            cell.configure(with: threat)
            cell.selectionStyle = .none
            return cell
        }
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
