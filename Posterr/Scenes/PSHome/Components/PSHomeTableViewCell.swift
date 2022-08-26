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
    private var imageLeadingConstraint: NSLayoutConstraint? = nil
    private var imageTrailingConstraint: NSLayoutConstraint? = nil
    private var stackLeadingConstraint: NSLayoutConstraint? = nil
    private var stackTrailingConstraint: NSLayoutConstraint? = nil

    // MARK: - Constants

    private struct Metrics {
        static let userImageSize: CGSize = CGSize(width: 48, height: 48)
    }
    
    private struct Constants { }
    
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
        customContentView.addSubview(messageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PSMetrics.mediumMargin),
            userImageView.heightAnchor.constraint(equalToConstant: Metrics.userImageSize.height),
            userImageView.widthAnchor.constraint(equalToConstant: Metrics.userImageSize.width),
            
            stackContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PSMetrics.mediumMargin),
            stackContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -PSMetrics.mediumMargin),

            messageView.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: PSMetrics.smallMargin),
            messageView.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -PSMetrics.smallMargin),
            messageView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: PSMetrics.smallMargin),
            messageView.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -PSMetrics.smallMargin)
        ])
    }
    
    private func setupNormalConstraint() {
        imageLeadingConstraint = userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PSMetrics.smallMargin)
        imageTrailingConstraint = nil
        stackLeadingConstraint = stackContentView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: PSMetrics.mediumMargin)
        stackTrailingConstraint = stackContentView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -PSMetrics.mediumMargin)
   
        imageLeadingConstraint?.isActive = true
        imageTrailingConstraint?.isActive = true
        stackLeadingConstraint?.isActive = true
        stackTrailingConstraint?.isActive = true
    }
    
    private func setupIsMeConstraint() {
        imageLeadingConstraint = nil
        imageTrailingConstraint = userImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PSMetrics.smallMargin)
        stackLeadingConstraint = stackContentView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: PSMetrics.mediumMargin)
        stackTrailingConstraint = stackContentView.trailingAnchor.constraint(equalTo: userImageView.leadingAnchor, constant: -PSMetrics.mediumMargin)
   
        imageLeadingConstraint?.isActive = true
        imageTrailingConstraint?.isActive = true
        stackLeadingConstraint?.isActive = true
        stackTrailingConstraint?.isActive = true
    }
    
    
    // MARK: - Public Functions

    public func setupUI(data: PSHomeFeedMessageEntity) {
        messageView.setupMessage(message: data.message, date: data.date)
        setupImage(photoURL: data.userAvatar)
        
        if data.isMe {
            setupIsMeConstraint()
        } else {
            setupNormalConstraint()
        }
        
        if let linkedMessage = data.linkedMessage {
            
        }
    }
    
    // MARK: - Private Functions
    
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


