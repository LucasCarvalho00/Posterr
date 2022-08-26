//
//  PSHomeDataView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 26/08/22.
//

import UIKit

public final class PSHomeDataView: UIView {
    
    // MARK: - Public Attributes
    // MARK: - Private Properties

    // MARK: - Constants
    
    private struct Metrics {
        static let buttonViewSize: CGSize = CGSize(width: 30, height: 30)
        static let maxStringMessage: Int = 777
    }
    
    private struct Constants {
        static let counterText = "0/" + String(Metrics.maxStringMessage)
    }
    
    // MARK: - Delegate

    public weak var delegate: PSHomeDataViewProtocol?
    
    // MARK: - UI
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var spaceTextView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .neutral30
        return view
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = PSFontStyle.smallComponent
        label.text = Constants.counterText
        return label
    }()
    
    private lazy var textView: PSTextView = {
        let textView = PSTextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        return textView
    }()
    
    private lazy var circularButton: PSCircularButtonView = {
        let button = PSCircularButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.delegate = self
        return button
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
        contentView.addSubview(spaceTextView)
        spaceTextView.addSubview(counterLabel)
        spaceTextView.addSubview(textView)
        spaceTextView.addSubview(circularButton)
    }
    
    private func setupConstraints() {
        contentView.constraintToSuperview()
        
        NSLayoutConstraint.activate([
            spaceTextView.bottomAnchor.constraint(equalTo: self.safeBottomAnchor),
            spaceTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spaceTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            counterLabel.topAnchor.constraint(equalTo: spaceTextView.topAnchor, constant: PSMetrics.smallMargin),
            counterLabel.leadingAnchor.constraint(equalTo: spaceTextView.leadingAnchor, constant: PSMetrics.smallMargin),

            textView.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: PSMetrics.tinyMargin),
            textView.bottomAnchor.constraint(equalTo: spaceTextView.bottomAnchor, constant: -PSMetrics.smallMargin),
            textView.leadingAnchor.constraint(equalTo: spaceTextView.leadingAnchor, constant: PSMetrics.smallMargin),
            
            circularButton.leadingAnchor.constraint(equalTo: textView.trailingAnchor, constant: PSMetrics.mediumMargin),
            circularButton.trailingAnchor.constraint(equalTo: spaceTextView.trailingAnchor, constant: -PSMetrics.mediumMargin),
            circularButton.heightAnchor.constraint(equalToConstant: Metrics.buttonViewSize.height),
            circularButton.widthAnchor.constraint(equalToConstant: Metrics.buttonViewSize.width),
            circularButton.centerYAnchor.constraint(equalTo: textView.centerYAnchor)
        ])
    }
    
    // MARK: - Private Functions

    // MARK: - Public Functions

    public func messageSentSuccessfully() {
        textView.text = ""
        counterLabel.text = Constants.counterText
    }
}

// MARK: - Extension

extension PSHomeDataView: PSTextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        counterLabel.text = String(textView.text.count) + "/" + String(Metrics.maxStringMessage)
    }
}

extension PSHomeDataView: PSCircularButtonViewDelegate {
    public func didTap(sender: PSCircularButtonView) {
        if textView.text.count == 0 {
            textView.setHasError()
            return
        }
        
        delegate?.sendMessage(message: textView.text)
    }
}
