//
//  PSUserProfileView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import UIKit

final public class PSUserProfileView: UIView {
    
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
    }
    
    private func addConstraints() {
        contentView.constraintToSuperview()
    }
    
    // MARK: - Private Functions
    
    private func setup(data: PSUserProfileViewEntity) {
    
    }
}

// MARK: - Extension

extension PSUserProfileView: PSUserProfileViewProtocol {
    public func setupUI(with viewState: PSUserProfileViewState) {
        switch viewState {
        case let .hasData(data):
            setup(data: data)
        case .isEmpty:
            break
        }
    }
}
