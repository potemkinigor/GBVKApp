//
//  ListOfFriends.swift
//  VKApp
//
//  Created by User on 23.03.2021.
//

import Foundation

struct ListOfFriends: Codable {
    let response: ListOfFriendsResponse?
}

struct ListOfFriendsResponse: Codable {
    let count: Int?
    let items: [ListOfFriendsItem]?
}

// MARK: - Item
struct ListOfFriendsItem: Codable {
    let firstName: String?
    let id: Int?
    let lastName: String?
    let canAccessClosed, isClosed: Bool?
    let photoURL: String?
    let trackCode: String?
    let deactivated: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case photoURL = "photo_200_orig"
        case trackCode = "track_code"
        case deactivated
    }
}
