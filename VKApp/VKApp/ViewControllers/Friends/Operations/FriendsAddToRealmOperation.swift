//
//  FriendsAddToRealmOperation.swift
//  VKApp
//
//  Created by User on 20.05.2021.
//

import Foundation

class FriendsAddToRealmOperation: Operation {
    let realmManager = RealmManager.shared
    
    override func main() {
        guard let friendsArray = dependencies.first as? FriendsPrepareForRealmOperation else { return }
        try? realmManager?.add(objects: friendsArray.outputData)
    }
}
