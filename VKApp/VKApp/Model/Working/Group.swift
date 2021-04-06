//
//  Group.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import Foundation
import SwiftUI
import RealmSwift

class Group: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatarURL: String = ""
    @objc dynamic var userIn: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, name: String, avatarURL: String, userIn: Bool) {
        self.init()
        self.id = id
        self.name = name
        self.avatarURL = avatarURL
        self.userIn = userIn
    }
}
