//
//  ImageCollectionViewCell.swift
//  VKApp
//
//  Created by User on 13.02.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 5
        self.layer.add(animation, forKey: nil)
    }
}
