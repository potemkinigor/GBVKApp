//
//  File.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import Foundation
import SwiftUI
import RealmSwift

class User: Object {
    
    //MARK: - person properties
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var surname: String = ""
    @objc dynamic var avatarURL: String = ""
    
    //MARK: - init

    convenience init(id: Int, name: String, surname: String, avatarURL: String) {
        self.init()
        self.id = id
        self.name = name
        self.surname = surname
        self.avatarURL = avatarURL
    }
    
}


