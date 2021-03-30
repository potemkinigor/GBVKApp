//
//  Session.swift
//  VKApp
//
//  Created by User on 21.03.2021.
//

import Foundation
import Alamofire

class Session {
    
    static let shared = Session()
    var photoCache = PhotoCache.shared
    
    var token: String!
    var userid: Int!
    
    private init () {
        
    }
    
    //MARK: - Private functions
    
    private func loadPhotoWithURL (photoURL: String) {
        
        if photoCache.cachedPhotoDictionary[photoURL] == nil {
            guard let url = URL(string: photoURL),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            
            photoCache.cachedPhotoDictionary[photoURL] = image
        } else {
            return
        }
    }
    
    //MARK: - Groups
    
    func loadUserGroups(complition: @escaping (ListOfGroups) -> Void) {
        
        var listOfGroups: ListOfGroups!
        
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let parameters: Parameters = [
            "access_token" : self.token!,
            "extended" : 1,
            "v" : "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseData(completionHandler: { (data) in
                guard let data = data.value else { return }
                do {
                    listOfGroups = try JSONDecoder().decode(ListOfGroups.self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
                
                listOfGroups.response?.items?.forEach({ (group) in
                    self.loadPhotoWithURL(photoURL: group.photo200URL!)
                })
                
                complition(listOfGroups)
            })
    }
    
    func loadFilteredGroups(filterText: String, complition: @escaping (ListOfGroups) -> Void) {
        
        var listOfGroups: ListOfGroups!
        
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let parameters: Parameters = [
            "access_token" : self.token!,
            "q" : filterText,
            "type" : "groups",
            "v" : "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseData { (data) in
                guard let data = data.value else { return }
                do {
                    listOfGroups = try JSONDecoder().decode(ListOfGroups.self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
                
                listOfGroups.response?.items?.forEach({ (group) in
                    self.loadPhotoWithURL(photoURL: group.photo200URL!)
                })
                
                complition(listOfGroups)
            }
    }
    
    //MARK: - Friends
    
    func loadUserFriends(completion: @escaping (ListOfFriends) -> Void) {
        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let parameters: Parameters = [
            "access_token" : self.token!,
            "order" : "random",
            "fields" : "first_name, first_name, photo_200_orig",
            "v" : "5.130"
        ]
        
        var listOfFriends: ListOfFriends!
        
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseData (completionHandler: { (data) in
                guard let data = data.value else { return }
                do {
                    listOfFriends = try JSONDecoder().decode(ListOfFriends.self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
                
                listOfFriends.response?.items?.forEach({ (friend) in
                    self.loadPhotoWithURL(photoURL: friend.photoURL!)
                })
            
                completion(listOfFriends)
            })
    }
    
    func getUsersPhoto (ownerID: Int, completion: @escaping ([UIImage]) -> Void) {
        
        var listOfPhotosArray: [UIImage] = []
        
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let parameters: Parameters = [
            "access_token" : self.token!,
            "owner_id" : ownerID,
            "v" : "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseData(completionHandler: { (data) in
                guard let data = data.value else { return }
                
                do {
                    let listOfPhotos = try JSONDecoder().decode(ListOfUserPhoto.self, from: data)
                    
                    listOfPhotos.response?.items!.forEach { (photoURL) in
                        let url = URL(string: photoURL.sizes![photoURL.sizes!.count - 1].url!)
                        let data = try? Data(contentsOf: url!)
                        let image = UIImage(data: data!)
                        
                        listOfPhotosArray.append(image!)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
                
                completion(listOfPhotosArray)
            })
        
        
    }
    
}
