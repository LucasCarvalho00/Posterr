//
//  PSTextView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import UIKit

public class PSTextView: UIView {
    
    // MARK: - Constants
    
    private struct Constants {
        static let borderWidth: CGFloat = 1
    }
            
    // MARK: - Delegate
        
    public var delegate: PSTextViewDelegate?
    
    // MARK: - Delegate

    public var text: String {
        get { textFieldView.text }
        set { textFieldView.text = newValue }
    }
    
    // MARK: - UI
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var textFieldView: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.layer.borderWidth = Constants.borderWidth
        textField.layer.borderColor = UIColor.neutral40.cgColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = PSMetrics.tinyMargin
        textField.isScrollEnabled = false
        textField.sizeToFit()
        textField.font = PSFontStyle.component
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
        contentView.addSubview(textFieldView)
    }
    
    private func setupConstraints() {
        contentView.constraintToSuperview()
        
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: contentView.topAnchor),
            textFieldView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    
    // MARK: - Public functions

    public func setHasError() {
        textFieldView.layer.borderColor = UIColor.secondary.cgColor
    }
    
    // MARK: - Private functions
    
    private func setFocusState() {
        textFieldView.layer.borderColor = UIColor.primary.cgColor
    }
    
    private func setNormalState() {
        textFieldView.layer.borderColor = UIColor.neutral40.cgColor
    }
    
    private func setHasError(error: String) {
        textFieldView.layer.borderColor = UIColor.secondary.cgColor
    }
}

//MARK: - Extensions

extension PSTextView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textField: UITextView) {
        setFocusState()
    }
    
    public func textViewDidEndEditing(_ textField: UITextView) {
        setNormalState()
    }

    public func textViewDidChange(_ textView: UITextView) {
        delegate?.textViewDidChange(textView)
    }
}
