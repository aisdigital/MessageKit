//
//  LayoutStyleUtil.swift
//  ChatExample
//
//  Created by Luiz Felipe Albernaz Pio on 01/10/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import UIKit
import MessageKit

class LayoutStyleUtil: NSObject {

    static let shared: LayoutStyleUtil = LayoutStyleUtil()
    
    private override init() {}
    
    lazy var outgoingContainerLayout: MessageStyle = {
        return MessageStyle.custom({ containerView in
            
            let path = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 10.0, height: 10.0))
            
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            containerView.layer.mask = mask
        })
    }()
    
    lazy var incomingContainerLayout: MessageStyle = {
        return MessageStyle.custom({ containerView in
            
            let path = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
            
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            containerView.layer.mask = mask
        })
    }()

}
