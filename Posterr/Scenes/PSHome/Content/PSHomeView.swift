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
    }
    
    private struct Constants {
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
    
    private lazy var textView: PSTextView = {
        let textView = PSTextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var circularButton: PSCircularButtonView = {
        let button = PSCircularButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
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
        spaceTextView.addSubview(textView)
        spaceTextView.addSubview(circularButton)
    }
    
    private func addConstraints() {
        contentView.constraintToSuperview()
        
        NSLayoutConstraint.activate([
            spaceTextView.bottomAnchor.constraint(equalTo: self.safeBottomAnchor),
            spaceTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spaceTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            textView.topAnchor.constraint(equalTo: spaceTextView.topAnchor, constant: PSMetrics.smallMargin),
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
}

// MARK: - Extension

extension PSHomeView: PSHomeViewProtocol {
    public func setupUI(with viewState: PSHomeViewState) {
        switch viewState {
        case let .hasData(data):
            setup(data: data)
        case .isEmpty:
            break
        }
    }
}
