/*
 MIT License
 
 Copyright (c) 2017-2019 MessageKit
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

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
    
    private var leftMarginConstraint: NSLayoutConstraint?
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = messageContainerView.frame.height * 0.1
        leftMarginConstraint?.constant = margin
    }
    
    open func setupConstraints() {
        
        fileImageView.translatesAutoresizingMaskIntoConstraints = false
        fileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leftMarginConstraint = fileImageView.leftAnchor.constraint(equalTo: messageContainerView.leftAnchor, constant: 0.0)
        let fileImageViewCenterYConstraint = fileImageView.centerYAnchor.constraint(equalTo: messageContainerView.centerYAnchor)
        let fileImageViewHeightConstraint = fileImageView.heightAnchor.constraint(equalTo: messageContainerView.heightAnchor, multiplier: 0.8)
        let fileImageViewWidthConstraint = fileImageView.widthAnchor.constraint(equalTo: messageContainerView.heightAnchor, multiplier: 0.8)
        
        //Label
        let labelLeftConstraint = fileNameLabel.leftAnchor.constraint(equalTo: fileImageView.rightAnchor, constant: 10)
        let labelRightConstraint = fileNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 15)
        let labelCenterYConstraint = fileNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        NSLayoutConstraint.activate([
            leftMarginConstraint,
            fileImageViewCenterYConstraint,
            fileImageViewHeightConstraint,
            fileImageViewWidthConstraint,
            labelLeftConstraint,
            labelRightConstraint,
            labelCenterYConstraint])
        
        self.leftMarginConstraint = leftMarginConstraint
    }
    
    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(fileImageView)
        messageContainerView.addSubview(fileNameLabel)
        setupConstraints()
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
