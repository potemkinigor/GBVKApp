//
//  ListOfUserPhoto.swift
//  VKApp
//
//  Created by User on 23.03.2021.
//

import Foundation

struct ListOfUserPhoto: Codable {
    let response: ListOfUserPhotoResponse?
}

// MARK: - Response
struct ListOfUserPhotoResponse: Codable {
    let count: Int?
    let items: [ListOfUserPhotoItem]?
    let more: Int?
}

// MARK: - Item
struct ListOfUserPhotoItem: Codable {
    let albumID, date, id, ownerID: Int?
    let hasTags: Bool?
    let sizes: [ListOfUserPhotoSize]?
    let text: String?
    let likes: ListOfUserPhotoLikes?
    let reposts: ListOfUserPhotoReposts?
    let realOffset: Int?
    let postID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text, likes, reposts
        case realOffset = "real_offset"
        case postID = "post_id"
    }
}

// MARK: - Likes
struct ListOfUserPhotoLikes: Codable {
    let userLikes, count: Int?

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct ListOfUserPhotoReposts: Codable {
    let count: Int?
}

// MARK: - Size
struct ListOfUserPhotoSize: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width: Int?
}
