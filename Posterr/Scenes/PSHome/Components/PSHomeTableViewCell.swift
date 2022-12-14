//
//  PSHomeTableViewCell.swift
//  Posterr
//
//  Created by Lucas Carvalho on 26/08/22.
//

import UIKit

public final class PSHomeTableViewCell: UITableViewCell {
    
    // MARK: - Private Attributes

    private var task: URLSessionDataTask?

    // MARK: - Constants

    private struct Metrics {
        static let userImageSize: CGSize = CGSize(width: 48, height: 48)
    }
        
    // MARK: - UI
    
    private lazy var stackContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = PSMetrics.smallMargin
        return stackView
    }()
    
    private lazy var stackCustomContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .trailing
        stackView.spacing = PSMetrics.smallMargin
        return stackView
    }()
    
    private lazy var customContentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = PSMetrics.smallMargin
        return contentView
    }()
    
    private lazy var messageView: PSFeedMessageView = {
        let view = PSFeedMessageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var linkedMessageView: PSFeedMessageView = {
        let view = PSFeedMessageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    private lazy var userImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .neutral40
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = PSMetrics.xxlMargin
        return image
    }()
    
    // MARK: - Initializers
    
    private override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        constraintUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    public override func prepareForReuse() {
        super.prepareForReuse()
        messageView.setupMessage(message: "", date: "")
        stackCustomContentView.removeArrangedSubview(linkedMessageView)
    }
    
    // MARK: - Setup

    private func setupCell() {
        contentView.backgroundColor = .neutral30
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    private func constraintUI() {
        contentView.addSubview(stackContentView)
        contentView.addSubview(userImageView)
        stackContentView.addArrangedSubview(customContentView)
        customContentView.addSubview(stackCustomContentView)
        stackCustomContentView.addArrangedSubview(messageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PSMetrics.mediumMargin),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PSMetrics.smallMargin),
            userImageView.heightAnchor.constraint(equalToConstant: Metrics.userImageSize.height),
            userImageView.widthAnchor.constraint(equalToConstant: Metrics.userImageSize.width),
            
            stackContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PSMetrics.mediumMargin),
            stackContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -PSMetrics.mediumMargin),
            stackContentView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: PSMetrics.mediumMargin),
            stackContentView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -PSMetrics.mediumMargin),
            
            stackCustomContentView.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: PSMetrics.smallMargin),
            stackCustomContentView.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -PSMetrics.smallMargin),
            stackCustomContentView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: PSMetrics.smallMargin),
            stackCustomContentView.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -PSMetrics.smallMargin)
        ])
    }
        
    // MARK: - Public Functions

    public func setupUI(data: PSHomeFeedMessageEntity) {
        messageView.setupMessage(message: data.message, date: data.date)
        setupImage(photoURL: data.userAvatar)
        setupTypeCell(typeOfMessage: data.typeOfMessage)
        
        if let linkedEntity = data.linkedMessage {
            linkedMessageView.setupMessage(message: linkedEntity.message, date: linkedEntity.date)
        }
    }
    
    // MARK: - Private Functions
    
    private func setupTypeCell(typeOfMessage: PSHomeFeedMessageTypeEntity) {
        switch typeOfMessage {
        case .normal:
            customContentView.backgroundColor = .white
            linkedMessageView.isHidden = true
        case .reply:
            stackCustomContentView.insertArrangedSubview(linkedMessageView, at: 0)
            linkedMessageView.isHidden = false
            customContentView.backgroundColor = .reply50
        case .quote:
            stackCustomContentView.insertArrangedSubview(linkedMessageView, at: 1)
            linkedMessageView.isHidden = false
            customContentView.backgroundColor = .quote50
        }
    }
    
    private func setupImage(photoURL: String) {
        if let urlPhoto = URL(string: photoURL) {
            let session = URLSession.shared
            task = session.dataTask(with: urlPhoto) { [weak userImageView] data, response, error in
                guard let data = data else {
                    return
                }
                
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    userImageView?.image = image
                }
            }
        
            task?.resume()
        }
    }
}


