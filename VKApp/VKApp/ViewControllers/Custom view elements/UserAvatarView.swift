//
//  UserAvatarView.swift
//  VKApp
//
//  Created by User on 08.02.2021.
//

import UIKit

@IBDesignable
class UserAvatarView: UIView {
    
    @IBOutlet var avatarImage: UIImageView! {
        didSet {
            self.avatarImage.layer.cornerRadius = self.cornerRadius
            self.avatarImage.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
            self.layer.shadowOpacity = 0.8
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .gray {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 2, animations: {
            let scale = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.transform = scale
        }, completion: {_ in
            UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, animations: {
                let scale = CGAffineTransform(scaleX: 1, y: 1)
                self.transform = scale
            })
        })
    }
    
    
}
