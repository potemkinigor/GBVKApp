//
//  AlphabetFriendsSearch.swift
//  VKApp
//
//  Created by User on 10.02.2021.
//

import Foundation
import UIKit


@IBDesignable
class AlphabetFriendsSearch: UIControl {
    var buttons: [UIButton] = []
    var stackView: UIStackView!
    var selectedChar: Character = "А" {
        didSet {
            self.sendActions(for: .valueChanged)
        }
    }
    
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        self.setupView()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    //MARK: - Private functions
    
    private func setupView () {
        
        for letter in alphabetArray {
            let button = UIButton(type: .system)
            button.setTitle(String(letter), for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.setTitleColor(.blue, for: .selected)
            button.setTitleColor(.blue, for: .focused)
            
            button.addTarget(self, action: #selector(selectNamesHeader(_:)), for: .touchDown)
            
            buttons.append(button)
        }

        stackView = UIStackView(arrangedSubviews: self.buttons)
        
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        self.addSubview(stackView)
        
        self.backgroundColor = UIColor(white: 1, alpha: 0)
    }

    @objc private func selectNamesHeader(_ sender: UIButton) {
        
        guard let senderIndex = self.buttons.firstIndex(of: sender) else { return }
        self.selectedChar = alphabetArray[senderIndex]
   
    }
    
}
