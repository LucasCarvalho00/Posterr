//
//  PSUserProfileDataView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 27/08/22.
//

import UIKit

public final class PSUserProfileDataView: UIView {

    // MARK: - Constants
    
    private struct Metrics {
        static let imageSize: CGSize = CGSize(width: 124, height: 124)
    }

    private struct Constants {
        static let userID: String = NSLocalizedString("User ID: ", comment: "")
        static let registerText: String = NSLocalizedString("Registration Date", comment: "")
        static let totalText: String = NSLocalizedString("Total messages", comment: "")
        static let dailyText: String = NSLocalizedString("Daily total", comment: "")
    }
    
    // MARK: - UI
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var userImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .neutral40
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = Metrics.imageSize.width / 2
        return image
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = PSFontStyle.title
        label.textAlignment = .center
        return label
    }()
    
    private lazy var userIDLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = PSFontStyle.component
        label.textAlignment = .center
        return label
    }()
    
    private lazy var createdTextFieldView: PSTextFieldView = {
        let textField = PSTextFieldView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setState(state: .disabled)
        return textField
    }()
    
    private lazy var totalMessagesTextFieldView: PSTextFieldView = {
        let textField = PSTextFieldView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setState(state: .disabled)
        return textField
    }()
    
    private lazy var todayMessagesTextFieldView: PSTextFieldView = {
        let textField = PSTextFieldView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setState(state: .disabled)
        return textField
    }()
    
    // MARK: - Life Cyle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        constraintUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func constraintUI() {
        addSubview(contentView)
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userIDLabel)
        contentView.addSubview(createdTextFieldView)
        contentView.addSubview(totalMessagesTextFieldView)
        contentView.addSubview(todayMessagesTextFieldView)
    }
    
    private func setupConstraints() {
        contentView.constraintToSuperview()
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PSMetrics.xxlMargin),
            userImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: Metrics.imageSize.height),
            userImageView.widthAnchor.constraint(equalToConstant: Metrics.imageSize.width),
            
            userNameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: PSMetrics.mediumMargin),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PSMetrics.xlMargin),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PSMetrics.xlMargin),
            
            userIDLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: PSMetrics.smallMargin),
            userIDLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PSMetrics.xlMargin),
            userIDLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PSMetrics.xlMargin),
            
            createdTextFieldView.topAnchor.constraint(equalTo: userIDLabel.bottomAnchor, constant: PSMetrics.xxxlMargin),
            createdTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PSMetrics.xlMargin),
            createdTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PSMetrics.xlMargin),
            
            totalMessagesTextFieldView.topAnchor.constraint(equalTo: createdTextFieldView.bottomAnchor),
            totalMessagesTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PSMetrics.xlMargin),
            totalMessagesTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PSMetrics.xlMargin),
            
            todayMessagesTextFieldView.topAnchor.constraint(equalTo: totalMessagesTextFieldView.bottomAnchor),
            todayMessagesTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PSMetrics.xlMargin),
            todayMessagesTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PSMetrics.xlMargin)
        ])
    }
    
    // MARK: - Public Functions

    public func setupData(data: PSUserProfileViewEntity) {
        userNameLabel.text = data.userName
        userIDLabel.text = Constants.userID + String(data.userID)
        
        createdTextFieldView.setupText(title: Constants.registerText, text: data.createdDate)
        totalMessagesTextFieldView.setupText(title: Constants.totalText, text: String(data.totalMessages))
        todayMessagesTextFieldView.setupText(title: Constants.dailyText, text: String(data.totalTodayMessages))
    }
}
