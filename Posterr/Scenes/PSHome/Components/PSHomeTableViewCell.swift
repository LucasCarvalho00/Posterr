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
        messageLabel.text = ""
        dateLabel.text = ""
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
        customContentView.addSubview(messageLabel)
        customContentView.addSubview(dateLabel)
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

            messageLabel.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: PSMetrics.smallMargin),
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: customContentView.leadingAnchor, constant: PSMetrics.smallMargin),
            messageLabel.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -PSMetrics.smallMargin),
            
            
            dateLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: PSMetrics.smallMargin),
            dateLabel.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -PSMetrics.smallMargin),
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: customContentView.leadingAnchor, constant: PSMetrics.smallMargin),
            dateLabel.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -PSMetrics.smallMargin),
        ])
    }
    
    // MARK: - Public Functions

    public func setupUI(data: PSHomeFeedMessageEntity) {
        messageLabel.text = data.message
        dateLabel.text = data.date
        setupImage(photoURL: data.userAvatar)
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


