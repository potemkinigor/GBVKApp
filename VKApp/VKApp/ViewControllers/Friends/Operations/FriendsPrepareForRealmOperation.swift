//
//  FriendsPrepareForRealmOperation.swift
//  VKApp
//
//  Created by User on 20.05.2021.
//

import Foundation
import UIKit

class FriendsPrepareForRealmOperation: Operation {
    var outputData: [User] = []
    
    override func main() {
        guard let parseData = dependencies.first as? FriendsParseDataOperation else { return }
        parseData.outputData?.response?.items?.forEach({ friend in
            outputData.append(User(id: friend.id!, name: friend.firstName!, surname: friend.lastName!, avatarURL: friend.photoURL!))
        })
    }
}
