//
//  FileMessageSizeCalculator.swift
//  MessageKit
//
//  Created by Luiz Felipe Albernaz Pio on 02/10/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import UIKit

open class FileMessageSizeCalculator: MessageSizeCalculator {
    open override func messageContainerSize(for message: MessageType) -> CGSize {
        switch message.kind {
        case .file:
            let maxWidth = messageContainerMaxWidth(for: message)
            let height = maxWidth * 0.2
            return CGSize(width: maxWidth, height: height)
        default:
            fatalError("messageContainerSize received unhandled MessageDataType: \(message.kind)")
        }
    }
}
