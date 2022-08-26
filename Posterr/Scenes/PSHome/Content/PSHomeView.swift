//
//  PSHomeView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import UIKit

public final class PSHomeView: UIView {
    
    // MARK: - Constants

    private struct Metrics { }
    
    private struct Constants { }
        
    // MARK: - Delegates
    
    public weak var delegate: PSHomeViewViewControllerProtocol?

    // MARK: - UI
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .neutral30
        return view
    }()
    
    private lazy var loadView: PSHomeLoadView = {
        let view = PSHomeLoadView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .neutral30
        return view
    }()
    
    private lazy var dataView: PSHomeDataView = {
        let view = PSHomeDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .neutral30
        view.delegate = self
        view.isHidden = true
        return view
    }()
    
    private lazy var errorView: PSHomeErrorView = {
        let view = PSHomeErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .neutral30
        view.delegate = self
        view.isHidden = true
        return view
    }()
    
    // MARK: - Life Cyle

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        self.backgroundColor = .neutral30
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
        contentView.addSubview(loadView)
        contentView.addSubview(dataView)
        contentView.addSubview(errorView)
    }
    
    private func addConstraints() {
        contentView.constraintToSafeArea()
        
        NSLayoutConstraint.activate([            
            loadView.topAnchor.constraint(equalTo: contentView.topAnchor),
            loadView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            loadView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            loadView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            dataView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dataView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            errorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    // MARK: - Private Functions
    
    private func setupLoad() {
        loadView.isHidden = false
        dataView.isHidden = true
        errorView.isHidden = true
    }
    
    private func setupData(data: PSHomeViewEntity) {
        loadView.isHidden = true
        dataView.isHidden = false
        errorView.isHidden = true
        
        dataView.setupData(data: data)
    }
    
    private func setupError() {
        loadView.isHidden = true
        dataView.isHidden = true
        errorView.isHidden = false
    }
    
    private func messageSentSuccessfully() {
        dataView.messageSentSuccessfully()
    }
}

// MARK: - Extension

extension PSHomeView: PSHomeViewProtocol {
    public func setupUI(with viewState: PSHomeViewState) {
        switch viewState {
        case let .hasData(data):
            setupData(data: data)
        case .hasError:
            setupError()
        case .loadScreen:
            setupLoad()
        case .messageSentSuccessfully:
            messageSentSuccessfully()
        }
    }
}

extension PSHomeView: PSHomeErrorViewDelegate {
    public func didTapReload() {
        delegate?.didTapReload()
    }
}

extension PSHomeView: PSHomeDataViewProtocol {
    public func sendMessage(message: String) {
        delegate?.sendMessage(message: message)
    }
}
