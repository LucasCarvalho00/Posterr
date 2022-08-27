//
//  PSCircularButtonView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import UIKit

public class PSCircularButtonView: UIView {
    
    // MARK: - Constants
    
    private struct Constants {
        static let customMargin: CGFloat = 6.0
        static let animationTouch: CGFloat = 0.15
    }
        
    // MARK: - Delegate

    public weak var delegate: PSCircularButtonViewDelegate?
    
    // MARK: - Public Properties

    public var customBackground: UIColor = .secondary {
        willSet(newColor) {
            contentView.backgroundColor = newColor
        }
    }
    
    public var customImage: UIImage? {
        get { iconView.image }
        set { iconView.image = newValue }
    }
    
    // MARK: - UI
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = PSMetrics.largeMargin
        contentView.isUserInteractionEnabled = true
        contentView.backgroundColor = .secondary
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        return contentView
    }()
    
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .icSend
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
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
        contentView.addSubview(iconView)
    }
    
    private func setupConstraints() {
        contentView.constraintToSuperview()
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.customMargin),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.customMargin),
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.customMargin),
            iconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.customMargin)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTap() {
        delegate?.didTap(sender: self)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentView.backgroundColor = .neutral60
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: Constants.animationTouch, animations: { [weak self] () -> Void in
            self?.contentView.backgroundColor = self?.customBackground
        })
    }
}
