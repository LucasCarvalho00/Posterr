//
//  PSLinkedMessageView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 26/08/22.
//

import UIKit

public final class PSLinkedMessageView: UIView {
    
    // MARK: - Constants
    
    private struct Metrics {
        static let numberOfLines: Int = 2
        static let buttonViewSize: CGSize = CGSize(width: 30, height: 30)
    }
    // MARK: - Delegate

    public weak var delegate: PSLinkedMessageViewDelegate?
    
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
    
    private lazy var feedMessageView: PSFeedMessageView = {
        let view = PSFeedMessageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = PSMetrics.smallMargin
        view.numberOfLines = Metrics.numberOfLines
        return view
    }()
    
    private lazy var buttonView: PSCircularButtonView = {
        let view = PSCircularButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.customBackground = .primary
        view.customImage = .icClose
        view.delegate = self
        return view
    }()
    
    // MARK: - Setup
    
    private func constraintUI() {
        addSubview(contentView)
        contentView.addSubview(feedMessageView)
        contentView.addSubview(buttonView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            feedMessageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PSMetrics.smallMargin),
            feedMessageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -PSMetrics.tinyMargin),
            feedMessageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PSMetrics.smallMargin),

            buttonView.leadingAnchor.constraint(equalTo: feedMessageView.trailingAnchor, constant: PSMetrics.mediumMargin),
            buttonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PSMetrics.mediumMargin),
            buttonView.heightAnchor.constraint(equalToConstant: Metrics.buttonViewSize.height),
            buttonView.widthAnchor.constraint(equalToConstant: Metrics.buttonViewSize.width),
            buttonView.centerYAnchor.constraint(equalTo: feedMessageView.centerYAnchor)
        ])
    }
    
    // MARK: - Public Functions

    public func setupMessage(message: String, date: String) {
        feedMessageView.setupMessage(message: message, date: date)
    }
}

// MARK: - Extension

extension PSLinkedMessageView: PSCircularButtonViewDelegate {
    public func didTap(sender: PSCircularButtonView) {
        delegate?.didTapClose()
    }
}
