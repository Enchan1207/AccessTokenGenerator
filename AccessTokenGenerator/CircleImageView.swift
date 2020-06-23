//
//  CircleImageView.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/23.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import UIKit
class CircleImageView: UIImageView {
    @IBInspectable var borderColor: UIColor = .white
    @IBInspectable var borderWidth: CGFloat = 0.1

    override var image: UIImage? {
        didSet{
            layer.masksToBounds = false
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = borderWidth
            layer.cornerRadius = frame.height/2
            clipsToBounds = true
        }
    }
}
