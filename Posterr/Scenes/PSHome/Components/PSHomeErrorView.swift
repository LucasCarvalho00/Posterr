//
//  PSHomeErrorView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 26/08/22.
//

import UIKit

public final class PSHomeErrorView: UIView {
    
    // MARK: - Constants
    
    private struct Metrics {
        static let borderWidth: CGFloat = 1.0
        static let bottonWidth: CGFloat = 130.0
        static let imageHeight: CGFloat = 200.0
    }
    
    private struct Constants {
        static let titleText: String = NSLocalizedString("Reload information", comment: "")
        static let contentText: String = NSLocalizedString("It was not possible to display the information at this time. How about trying again?", comment: "")
        static let buttonText: String = NSLocalizedString("RELOAD", comment: "")
    }
    
    // MARK: - Delegates
    
    public weak var delegate: PSHomeErrorViewDelegate?
    
    // MARK: - Life Cyle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        constraintUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var alertImage: UIImageView = {
        let image = UIImageView()
        image.image = .imageAlert
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = Constants.titleText
        label.font = PSFontStyle.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cotentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = Constants.contentText
        label.font = PSFontStyle.component
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.buttonText, for: .normal)
        button.setTitleColor(.primary ,for: .normal)
        button.layer.borderColor = UIColor.primary.cgColor
        button.layer.borderWidth = Metrics.borderWidth
        button.layer.cornerRadius = PSMetrics.tinyMargin
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = PSFontStyle.component
        button.addTarget(self, action: #selector(didTapReload), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    
    @objc private func didTapReload() {
        delegate?.didTapReload()
    }
    
    // MARK: - Setup
    
    private func constraintUI() {
        addSubview(alertImage)
        addSubview(titleLabel)
        addSubview(cotentLabel)
        addSubview(reloadButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            alertImage.topAnchor.constraint(equalTo: topAnchor, constant: PSMetrics.xxlMargin),
            alertImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertImage.heightAnchor.constraint(equalToConstant: Metrics.imageHeight),

            titleLabel.topAnchor.constraint(equalTo: alertImage.bottomAnchor, constant: PSMetrics.xxlMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: PSMetrics.xlMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -PSMetrics.xlMargin),
            
            cotentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: PSMetrics.xlMargin),
            cotentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: PSMetrics.xlMargin),
            cotentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -PSMetrics.xlMargin),
            
            reloadButton.topAnchor.constraint(equalTo: cotentLabel.bottomAnchor, constant: PSMetrics.xxlMargin),
            reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            reloadButton.widthAnchor.constraint(equalToConstant: Metrics.bottonWidth)
        ])
    }
}
