//
//  FriendsParseDataOperation.swift
//  VKApp
//
//  Created by User on 20.05.2021.
//

import Foundation
import Alamofire

class FriendsParseDataOperation: Operation {
    
    var outputData: ListOfFriends?
    
    override func main() {
        guard let getDataOperation = dependencies.first as? FriendsGetDataOperations,
              let data = getDataOperation.data else { return }
        
        let listOfFriends = try? JSONDecoder().decode(ListOfFriends.self, from: data)
    
        outputData = listOfFriends
    }
}
