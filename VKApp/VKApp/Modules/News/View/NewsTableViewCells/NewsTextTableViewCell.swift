//
//  NewsTextTableViewCell.swift
//  VKApp
//
//  Created by User on 16.05.2021.
//

import UIKit

class NewsTextTableViewCell: UITableViewCell {

    @IBOutlet weak var textNewsView: UIView!
    @IBOutlet weak var textNewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
