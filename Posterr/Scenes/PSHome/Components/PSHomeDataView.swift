//
//  PSHomeDataView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 26/08/22.
//

import UIKit

public final class PSHomeDataView: UIView {
    
    // MARK: - Private Properties
    
    private var feedsItens: [PSHomeFeedMessageEntity] = []
    private var linkedMessage: PSHomeFeedNewLinkedMessageEntity?
    private var typeMessage: PSHomeViewNewMessageTypeEntity = .normal
    
    // MARK: - Constants
    
    private struct Metrics {
        static let heightReplyStackView: CGFloat = 40.0
        static let buttonViewSize: CGSize = CGSize(width: 30, height: 30)
        static let maxStringMessage: Int = 777
    }
    
    private struct Constants {
        static let counterText = "0/" + String(Metrics.maxStringMessage)
        static let reply = NSLocalizedString("Reply", comment: "")
        static let quote = NSLocalizedString("Quote", comment: "")
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
    
    private lazy var stackLinkedMessageView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = PSMetrics.smallMargin
        return stackView
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
        textView.maxOfStrings = Metrics.maxStringMessage
        return textView
    }()
    
    private lazy var circularButton: PSCircularButtonView = {
        let button = PSCircularButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.delegate = self
        return button
    }()
    
    private lazy var linkedMessageView: PSLinkedMessageView = {
        let view = PSLinkedMessageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .neutral30
        view.isHidden = true
        view.delegate = self
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PSHomeTableViewCell.self, forCellReuseIdentifier: PSHomeTableViewCell.className)
        tableView.register(PSHomeTableIsMeViewCell.self, forCellReuseIdentifier: PSHomeTableIsMeViewCell.className)
        tableView.showsHorizontalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .neutral30
        return tableView
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
        contentView.addSubview(tableView)
        contentView.addSubview(stackLinkedMessageView)
        stackLinkedMessageView.addArrangedSubview(linkedMessageView)
        stackLinkedMessageView.addArrangedSubview(spaceTextView)
        spaceTextView.addSubview(counterLabel)
        spaceTextView.addSubview(textView)
        spaceTextView.addSubview(circularButton)
    }
    
    private func setupConstraints() {
        contentView.constraintToSuperview()
        
        NSLayoutConstraint.activate([
            stackLinkedMessageView.bottomAnchor.constraint(equalTo: self.safeBottomAnchor),
            stackLinkedMessageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackLinkedMessageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: self.safeTopAnchor),
            tableView.bottomAnchor.constraint(equalTo: stackLinkedMessageView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
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

    private func setupReply(entity: PSHomeFeedMessageEntity) {
        linkedMessageView.isHidden = false
        linkedMessageView.setupMessage(message: entity.message, date: entity.date)
        textView.customBackground = .reply50
        linkedMessage = makePSHomeFeedNewLinkedMessageEntity(entity: entity)
        typeMessage = .reply

        DispatchQueue.main.async {
            let index = IndexPath(row: self.feedsItens.count - 1, section: 0)
            self.tableView.scrollToRow(at: index, at: .bottom, animated: false)
        }
    }
    
    private func setupQuote(entity: PSHomeFeedMessageEntity) {
        linkedMessageView.isHidden = false
        linkedMessageView.setupMessage(message: entity.message, date: entity.date)
        textView.customBackground = .quote50
        linkedMessage = makePSHomeFeedNewLinkedMessageEntity(entity: entity)
        typeMessage = .quote
        
        DispatchQueue.main.async {
            let index = IndexPath(row: self.feedsItens.count - 1, section: 0)
            self.tableView.scrollToRow(at: index, at: .bottom, animated: false)
        }
    }
    
    private func setupCloseLinkedMessage() {
        linkedMessageView.isHidden = true
        linkedMessageView.setupMessage(message: "", date: "")
        textView.customBackground = .white
        linkedMessage = nil
        typeMessage = .normal

        DispatchQueue.main.async {
            let index = IndexPath(row: self.feedsItens.count - 1, section: 0)
            self.tableView.scrollToRow(at: index, at: .bottom, animated: false)
        }
    }
    
    private func makePSHomeFeedNewLinkedMessageEntity(entity: PSHomeFeedMessageEntity) -> PSHomeFeedNewLinkedMessageEntity {
        PSHomeFeedNewLinkedMessageEntity(
            userID: entity.userID,
            userAvatar: entity.userAvatar,
            message: entity.message,
            date: entity.date)
    }
    
    // MARK: - Public Functions

    public func setupData(data: PSHomeViewEntity) {
        if let feeds = data.feeds {
            feedsItens = feeds
        }
        
        tableView.reloadData()
        
        DispatchQueue.main.async {
            let index = IndexPath(row: self.feedsItens.count-1, section: 0)
            self.tableView.scrollToRow(at: index, at: .bottom, animated: false)
        }
    }
    
    public func insertNewMessage(entity: PSHomeFeedMessageEntity) {
        feedsItens.append(entity)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath.init(row: feedsItens.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        setupCloseLinkedMessage()

        DispatchQueue.main.async {
            let index = IndexPath(row: self.feedsItens.count - 1, section: 0)
            self.tableView.scrollToRow(at: index, at: .bottom, animated: true)
        }
    }
    
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
        
        let entity = PSHomeViewNewMessageEntity(
            message: textView.text,
            typeMessage: typeMessage,
            linkedMessage: linkedMessage)
        
        delegate?.sendMessage(entity: entity)
    }
}

extension PSHomeDataView: PSLinkedMessageViewDelegate {
    public func didTapClose() {
        setupCloseLinkedMessage()
    }
}

extension PSHomeDataView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentEntity = feedsItens[indexPath.row]
        
        if currentEntity.isMe {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PSHomeTableIsMeViewCell.className,
                                                           for: indexPath) as? PSHomeTableIsMeViewCell else {
                return UITableViewCell()
            }
            
            cell.setupUI(data: currentEntity)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PSHomeTableViewCell.className,
                                                           for: indexPath) as? PSHomeTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setupUI(data: currentEntity)
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedsItens.count
    }
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let currentEntity = feedsItens[indexPath.row]

        let reply = UIContextualAction(style: .normal, title: Constants.reply, handler: { [weak self] (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            self?.setupReply(entity: currentEntity)
            success(true)
        })
        reply.backgroundColor = .reply
        
        let quote = UIContextualAction(style: .normal, title: Constants.quote, handler: { [weak self] (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            self?.setupQuote(entity: currentEntity)
            success(true)
            
        })
        quote.backgroundColor = .quote
        
        return UISwipeActionsConfiguration(actions: [reply, quote])
    }
}

extension PSHomeDataView: UITableViewDelegate { }
