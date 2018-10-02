//
//  FileMessageCell.swift
//  MessageKit
//
//  Created by Luiz Felipe Albernaz Pio on 02/10/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import UIKit

open class FileMessageCell: MessageContentCell {
    
    private var fileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = ContentMode.scaleAspectFit
        return imageView
    }()
    
    open var fileNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    open func setupConstraints() {
        
        let fileImageViewLeftConstraint = fileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15)
        let fileImageViewCenterYConstraint = fileImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        let fileImageViewHeightConstraint = fileImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8)
        let fileImageViewWidthConstraint = fileImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8)
        
        //Label
        let labelLeftConstraint = fileNameLabel.leftAnchor.constraint(equalTo: fileImageView.rightAnchor, constant: 10)
        let labelRightConstraint = fileNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 15)
        let labelCenterYConstraint = fileNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        fileImageView.translatesAutoresizingMaskIntoConstraints = false
        fileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fileImageViewLeftConstraint,
            fileImageViewCenterYConstraint,
            fileImageViewHeightConstraint,
            fileImageViewWidthConstraint,
            labelLeftConstraint,
            labelRightConstraint,
            labelCenterYConstraint])
    }
    
    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(fileImageView)
        messageContainerView.addSubview(fileNameLabel)
        setupConstraints()
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)

        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }
        
        switch message.kind {
        case .file(let fileName):
            fileNameLabel.text = fileName
        default:
            break
        }
        
        displayDelegate.configureFileMessageLabel(fileNameLabel, for: message, at: indexPath, in: messagesCollectionView)
        
        displayDelegate.configureFileMessageImageView(fileImageView, for: message, at: indexPath, in: messagesCollectionView)
    }
}
