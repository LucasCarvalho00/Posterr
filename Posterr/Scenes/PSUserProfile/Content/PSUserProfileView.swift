//
//  PSUserProfileView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import UIKit

public final class PSUserProfileView: UIView {
    
    // MARK: - Constants

    private struct Metrics {
    }
    
    private struct Constants {
    }
    
    // MARK: - Delegates
    
    public weak var delegate: PSUserProfileViewViewControllerProtocol?

    // MARK: - UI
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var loadView: PSUserProfileLoadView = {
        let view = PSUserProfileLoadView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .neutral30
        return view
    }()
    
    private lazy var dataView: PSUserProfileDataView = {
        let view = PSUserProfileDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .neutral30
        view.isHidden = true
        return view
    }()
    
    private lazy var errorView: PSUserProfileErrorView = {
        let view = PSUserProfileErrorView()
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
    
    private func setupData(data: PSUserProfileViewEntity) {
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
}

// MARK: - Extension

extension PSUserProfileView: PSUserProfileViewProtocol {
    public func setupUI(with viewState: PSUserProfileViewState) {
        switch viewState {
        case .loadScreen:
            setupLoad()
        case let .hasData(data):
            setupData(data: data)
        case .hasError:
            setupError()
        }
    }
}

extension PSUserProfileView: PSUserProfileErrorViewDelegate {
    public func didTapReload() {
        delegate?.didTapReload()
    }
}
