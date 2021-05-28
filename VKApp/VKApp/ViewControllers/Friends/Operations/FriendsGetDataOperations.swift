//
//  FriendsGetDataOperations.swift
//  VKApp
//
//  Created by User on 20.05.2021.
//

import Foundation
import Alamofire

class FriendsGetDataOperations: Operation {
    
    private var request: DataRequest
    var data: Data?
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
        }
    }
    
    init(request: DataRequest) {
        self.request = request
    }
    
}

