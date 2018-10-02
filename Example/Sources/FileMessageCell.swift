//
//  FileMessageCell.swift
//  ChatExample
//
//  Created by Luiz Felipe Albernaz Pio on 02/10/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import UIKit
import MessageKit

class FileMessageCell: UICollectionViewCell {

    @IBOutlet weak var fileNameLabel: UILabel!
    
    var outgoing: Bool = true {
        didSet {
            setBackgroundBasedOnSender(outgoing: outgoing)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setBackgroundBasedOnSender(outgoing: Bool) {
        if outgoing {
            backgroundColor = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }
        backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    }
}

class FileMessageFlowLayout: MessagesCollectionViewFlowLayout {
    lazy var fileMessageSizeCalculator = FileMessageSizeCalculator(layout: self)
    
    override func cellSizeCalculatorForItem(at indexPath: IndexPath) -> CellSizeCalculator {
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        if case .custom = message.kind {
            return fileMessageSizeCalculator
        }
        return super.cellSizeCalculatorForItem(at: indexPath)
    }
}

class FileMessageSizeCalculator: MessageSizeCalculator {
    override func messageContainerSize(for message: MessageType) -> CGSize {
        return CGSize(width: 350, height: 60)
    }
}
