//
//  GroupsAvatarView.swift
//  VKApp
//
//  Created by User on 08.02.2021.
//

import UIKit

@IBDesignable
class GroupsAvatarView: UIView {
    
    @IBOutlet var groupAvatar: UIImageView! {
        didSet {
            self.groupAvatar.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .gray {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOpacity = 0.8
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
