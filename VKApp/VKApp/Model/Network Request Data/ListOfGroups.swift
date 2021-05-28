//
//  ListOfGroups.swift
//  VKApp
//
//  Created by User on 23.03.2021.
//

import Foundation

struct ListOfGroups: Codable {
    let response: ListOfGroupsResponse?
}

// MARK: - Response
struct ListOfGroupsResponse: Codable {
    let count: Int?
    let items: [ListOfGroupsItem]?
}

// MARK: - Item
struct ListOfGroupsItem: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: String?
    let isAdmin, isMember, isAdvertiser: Int?
    let photo50URL, photo100URL, photo200URL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50URL = "photo_50"
        case photo100URL = "photo_100"
        case photo200URL = "photo_200"
    }
}
