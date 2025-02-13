//
//  ThreatCell.swift
//  Icaro Assignment
//
//  Created by Jai Nijhawan on 12/02/25.
//

import UIKit

class ThreatCell: UITableViewCell {
    
    static let identifier = "ThreatCell"
    
    private let threatLabel = UILabel()
    private let urlLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        threatLabel.font = UIFont.boldSystemFont(ofSize: 16)
        urlLabel.font = UIFont.systemFont(ofSize: 14)
        urlLabel.textColor = .gray
        urlLabel.numberOfLines = 2
        
        let stackView = UIStackView(arrangedSubviews: [threatLabel, urlLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with threat: ThreatModel) {
        threatLabel.text = "Threat: \(threat.threat)"
        urlLabel.text = threat.url
    }
}
