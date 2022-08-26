//
//  PSCircularButtonView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import UIKit

public class PSCircularButtonView: UIView {
    
}

//
//  SWTextFieldView.swift
//  Swile
//
// swiftlint:disable all
//  Created byLucas Carvalho on 27/05/22.
//  Copyright © 2022 Swile. All rights reserved.
//

import UIKit

public class SWTextFieldView: UIView {
    
    // MARK: - Constants
    
    private struct Constants { }
    
    // MARK: - Public Attributes
    
    // MARK: - Private Attributes
        
    // MARK: - Delegate
        
    // MARK: - UI
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
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
    }
    
    private func setupConstraints() {
        contentView.constraintToSuperview()
    }
    
    
    // MARK: - Private functions
    
}

//MARK: - Extensions


