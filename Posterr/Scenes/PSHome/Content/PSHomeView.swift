//
//  PSHomeView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import UIKit

final public class PSHomeView: UIView {
    
    // MARK: - Constants

    private struct Metrics {
        static let minimumTextViewHeight: CGFloat = 24.0
        static let buttonViewSize: CGSize = CGSize(width: 30, height: 30)
        static let maxStringMessage: Int = 777
    }
    
    private struct Constants {
        static let counterText = "0/" + String(Metrics.maxStringMessage)
    }
        
    // MARK: - Delegates
    
    public weak var delegate: PSHomeViewViewControllerProtocol?

    // MARK: - UI
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .neutral30
        return view
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

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup

    func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(contentView)
        contentView.addSubview(spaceTextView)
        spaceTextView.addSubview(counterLabel)
        spaceTextView.addSubview(textView)
        spaceTextView.addSubview(circularButton)
    }
    
    private func addConstraints() {
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
    
    private func setup(data: PSHomeViewEntity) {
    
    }
    
    private func messageSentSuccessfully() {
        textView.text = ""
    }
}

// MARK: - Extension

extension PSHomeView: PSHomeViewProtocol {
    public func setupUI(with viewState: PSHomeViewState) {
        switch viewState {
        case let .hasData(data):
            setup(data: data)
        case .messageSentSuccessfully:
            messageSentSuccessfully()
        }
    }
}

extension PSHomeView: PSTextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        counterLabel.text = String(textView.text.count) + "/" + String(Metrics.maxStringMessage)
    }
}

extension PSHomeView: PSCircularButtonViewDelegate {
    public func didTap(sender: PSCircularButtonView) {
        if textView.text.count == 0 {
            textView.setHasError()
            return
        }
        
        delegate?.sendMessage(message: textView.text)
    }
}
