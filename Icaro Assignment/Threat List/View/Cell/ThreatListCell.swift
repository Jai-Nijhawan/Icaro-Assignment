//
//  ThreatCell.swift
//  Icaro Assignment
//
//  Created by Jai Nijhawan on 12/02/25.
//

import UIKit

final class ThreatListCell: UITableViewCell {
    
    static let identifier = "ThreatListCell"
    
    private let innerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        return view
    }()
    
    private let statusIndicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let threatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let threatDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor.systemGray6
        
        contentView.addSubview(innerContainerView)
        innerContainerView.addSubview(statusIndicatorView)
        innerContainerView.addSubview(threatLabel)
        innerContainerView.addSubview(threatDescriptionLabel)
        innerContainerView.addSubview(arrowImageView)
        
        NSLayoutConstraint.activate([
            // Padding for the cell
            innerContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            innerContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            innerContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            innerContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

            statusIndicatorView.leadingAnchor.constraint(equalTo: innerContainerView.leadingAnchor, constant: 12),
            statusIndicatorView.centerYAnchor.constraint(equalTo: innerContainerView.centerYAnchor),
            statusIndicatorView.widthAnchor.constraint(equalToConstant: 12),
            statusIndicatorView.heightAnchor.constraint(equalToConstant: 12),
            
            threatLabel.topAnchor.constraint(equalTo: innerContainerView.topAnchor, constant: 12),
            threatLabel.leadingAnchor.constraint(equalTo: statusIndicatorView.trailingAnchor, constant: 12),
            threatLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -10),
            
            threatDescriptionLabel.topAnchor.constraint(equalTo: threatLabel.bottomAnchor, constant: 4),
            threatDescriptionLabel.leadingAnchor.constraint(equalTo: statusIndicatorView.trailingAnchor, constant: 12),
            threatDescriptionLabel.trailingAnchor.constraint(equalTo: innerContainerView.trailingAnchor, constant: -16),
            threatDescriptionLabel.bottomAnchor.constraint(equalTo: innerContainerView.bottomAnchor, constant: -12),

            arrowImageView.trailingAnchor.constraint(equalTo: innerContainerView.trailingAnchor, constant: -12),
            arrowImageView.centerYAnchor.constraint(equalTo: innerContainerView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 10),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    func configure(with threat: ThreatModel) {
        threatLabel.text = threat.threat
        threatDescriptionLabel.text = threat.urlhausReference

        // Set color based on `url_status`
        switch threat.urlStatus.lowercased() {
        case "online":
            statusIndicatorView.backgroundColor = .orange
        case "offline":
            statusIndicatorView.backgroundColor = .yellow
        default:
            statusIndicatorView.backgroundColor = .gray
        }
    }
}
