//
//  GeneratedTokenVC.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/20.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation
import UIKit

class GeneratedTokenViewController: UIViewController {
    var generatedUser: User? = nil
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var tokensecretLabel: UILabel!
    
    @IBOutlet weak var titleBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tokenLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var tokensecretLabelConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIアニメーション初期化
        titleLabel.alpha = 0
        titleBottomConstraint.constant = 200
        tokenLabelConstraint.constant = -self.view.frame.width
        tokensecretLabelConstraint.constant = -self.view.frame.width
        self.view.layoutIfNeeded()
        
        // トークン設定
        if let token = generatedUser?.token{
            tokenLabel.text = token.key
            tokensecretLabel.text = token.secret
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // UIアニメーション
        titleLabel.alpha = 1
        titleBottomConstraint.constant = 30
        tokenLabelConstraint.constant = 0
        tokensecretLabelConstraint.constant = 0
        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            options: UIView.AnimationOptions.allowUserInteraction,
            animations: {
                self.view.layoutIfNeeded()
        },
            completion:nil
        );
    }
    
    @IBAction func onTapCopyToken(_ sender: UIButton) {
        if let token = self.generatedUser?.token {
            let tokenstr = "key: \(token.key)\nsecret: \(token.secret)"
            UIPasteboard.general.string = tokenstr
            
            sender.setTitle("Copied!", for: .normal)
        }
    }
    
}
