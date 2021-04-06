//
//  PhotoCache.swift
//  VKApp
//
//  Created by User on 30.03.2021.
//

import Foundation
import UIKit

class PhotoCache {
    
    static let shared = PhotoCache()
    
    var cachedPhotoDictionary: [String : UIImage] = [ : ]
    
    private init() {
        
    }
}
