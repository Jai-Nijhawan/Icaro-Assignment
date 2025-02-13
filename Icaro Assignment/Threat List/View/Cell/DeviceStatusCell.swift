//
//  DeviceStatusCell.swift
//  Icaro Assignment
//
//  Created by Jai Nijhawan on 12/02/25.
//

import UIKit

final class DeviceStatusCell: UITableViewCell {

    static let identifier = "DeviceStatusCell"
    
    private let statusTileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.orange
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let riskStatusIconContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let riskStatusIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "exclamationmark.circle.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let riskStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Device at High Risk!"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()
    
    private let lastScanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Last Scan - \(Utils.getCurrentFormattedTime())"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let startScanButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Scan", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.brown
        button.tintColor = .white
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let protectionStatusContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemGray5
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let protectionStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "App Protection:"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let protectionStatusStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enabled"  // Default state
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor.systemPurple
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        contentView.addSubview(statusTileView)
        contentView.addSubview(protectionStatusContainer)
        
        statusTileView.addSubview(riskStatusIconContainer)
        riskStatusIconContainer.addSubview(riskStatusIcon)
        
        statusTileView.addSubview(riskStatusLabel)
        statusTileView.addSubview(lastScanLabel)
        statusTileView.addSubview(startScanButton)
        
        protectionStatusContainer.addSubview(protectionStatusLabel)
        protectionStatusContainer.addSubview(protectionStatusStateLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            statusTileView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            statusTileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            statusTileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            riskStatusIconContainer.topAnchor.constraint(equalTo: statusTileView.topAnchor, constant: 16),
            riskStatusIconContainer.leadingAnchor.constraint(equalTo: statusTileView.leadingAnchor, constant: 16),
            riskStatusIconContainer.widthAnchor.constraint(equalToConstant: 85),
            riskStatusIconContainer.heightAnchor.constraint(equalToConstant: 85),

            riskStatusIcon.centerXAnchor.constraint(equalTo: riskStatusIconContainer.centerXAnchor),
            riskStatusIcon.centerYAnchor.constraint(equalTo: riskStatusIconContainer.centerYAnchor),
            riskStatusIcon.widthAnchor.constraint(equalToConstant: 85),
            riskStatusIcon.heightAnchor.constraint(equalToConstant: 85),
            
            riskStatusLabel.topAnchor.constraint(equalTo: riskStatusIcon.bottomAnchor, constant: 8),
            riskStatusLabel.leadingAnchor.constraint(equalTo: statusTileView.leadingAnchor, constant: 16),
            riskStatusLabel.trailingAnchor.constraint(equalTo: statusTileView.trailingAnchor, constant: -16),
            
            lastScanLabel.topAnchor.constraint(equalTo: riskStatusLabel.bottomAnchor, constant: 4),
            lastScanLabel.leadingAnchor.constraint(equalTo: statusTileView.leadingAnchor, constant: 16),
            lastScanLabel.trailingAnchor.constraint(equalTo: statusTileView.trailingAnchor, constant: -16),

            startScanButton.topAnchor.constraint(equalTo: lastScanLabel.bottomAnchor, constant: 16),
            startScanButton.leadingAnchor.constraint(equalTo: statusTileView.leadingAnchor, constant: 16),
            startScanButton.trailingAnchor.constraint(lessThanOrEqualTo: statusTileView.trailingAnchor, constant: -16),
            startScanButton.bottomAnchor.constraint(equalTo: statusTileView.bottomAnchor, constant: -16),
            startScanButton.widthAnchor.constraint(equalToConstant: 200),
            startScanButton.heightAnchor.constraint(equalToConstant: 50),

            protectionStatusContainer.topAnchor.constraint(equalTo: statusTileView.bottomAnchor, constant: 12),
            protectionStatusContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            protectionStatusContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            protectionStatusContainer.heightAnchor.constraint(equalToConstant: 40),
            protectionStatusContainer.widthAnchor.constraint(greaterThanOrEqualToConstant: 180),

            protectionStatusLabel.leadingAnchor.constraint(equalTo: protectionStatusContainer.leadingAnchor, constant: 12),
            protectionStatusLabel.centerYAnchor.constraint(equalTo: protectionStatusContainer.centerYAnchor),

            protectionStatusStateLabel.leadingAnchor.constraint(equalTo: protectionStatusLabel.trailingAnchor, constant: 6),
            protectionStatusStateLabel.trailingAnchor.constraint(equalTo: protectionStatusContainer.trailingAnchor, constant: -12),
            protectionStatusStateLabel.centerYAnchor.constraint(equalTo: protectionStatusContainer.centerYAnchor),
        ])
    }

    func configure(withProtectionStatus isEnabled: Bool) {
        protectionStatusStateLabel.text = isEnabled ? "Enabled" : "Disabled"
        protectionStatusStateLabel.textColor = isEnabled ? UIColor.systemGreen : UIColor.systemRed
    }
}
