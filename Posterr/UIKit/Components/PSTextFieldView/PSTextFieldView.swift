//
//  PSTextFieldView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 27/08/22.
//

import UIKit

public enum SWTextFieldViewState {
    case disabled
}

public class PSTextFieldView: UIView {
    
    // MARK: - Constants

    private struct Constants {
        static let borderWidth: CGFloat = 1
        static let textFieldHeight: CGFloat = 42.0
    }
    
    // MARK: - UI
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .neutral30
        return contentView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = PSFontStyle.component
        return label
    }()

    public lazy var textFieldView: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = Constants.borderWidth
        textField.layer.borderColor = UIColor.neutral40.cgColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = PSMetrics.tinyMargin
        textField.setLeftPaddingPoints(PSMetrics.mediumMargin)
        textField.setRightPaddingPoints(PSMetrics.mediumMargin)
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
        contentView.addSubview(textLabel)
        contentView.addSubview(textFieldView)
    }
    
    private func setupConstraints() {
        contentView.constraintToSuperview()
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PSMetrics.mediumMargin),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PSMetrics.xlMargin),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PSMetrics.xlMargin),
            
            textFieldView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: PSMetrics.tinyMargin),
            textFieldView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -PSMetrics.mediumMargin),
            textFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PSMetrics.xlMargin),
            textFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PSMetrics.xlMargin),
            textFieldView.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight)
        ])
    }
    
    // MARK: - Public functions

    public func setupText(title: String, text: String) {
        textLabel.text = title
        textFieldView.text = text
    }
    
    public func setState(state: SWTextFieldViewState) {
        switch state {
        case .disabled:
            setDisabled()
        }
    }
    
    // MARK: - Private functions

    private func setDisabled() {
        textFieldView.layer.borderColor = UIColor.neutral40.cgColor
        textFieldView.layer.backgroundColor = UIColor.neutral40.cgColor
        
        textFieldView.isUserInteractionEnabled = false
    }
}
