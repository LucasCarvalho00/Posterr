//
//  PSFeedMessageView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 26/08/22.
//

import UIKit

public final class PSFeedMessageView: UIView {
    
    // MARK: - Life Cyle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        constraintUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = PSFontStyle.component
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neutral60
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = PSFontStyle.component
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Setup
    
    private func constraintUI() {
        addSubview(contentView)
        contentView.addSubview(messageLabel)
        contentView.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PSMetrics.smallMargin),
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: PSMetrics.smallMargin),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PSMetrics.smallMargin),
            
            dateLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: PSMetrics.smallMargin),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -PSMetrics.smallMargin),
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: PSMetrics.smallMargin),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PSMetrics.smallMargin),
        ])
    }
    
    // MARK: - Public Functions

    public func setupMessage(message: String, date: String) {
        messageLabel.text = message
        dateLabel.text = date
    }
}
