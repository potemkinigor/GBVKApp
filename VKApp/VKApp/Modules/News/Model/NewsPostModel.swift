//
//  NewsPostModel.swift
//  VKApp
//
//  Created by User on 20.05.2021.
//

import Foundation

struct NewsPostModel: Codable {
    let response: NewsPostResponse?
}

// MARK: - Response
struct NewsPostResponse: Codable {
    let items: [NewsPostItem]?
    let profiles: [NewsPostProfile]?
    let groups: [NewsPostGroup]?
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct NewsPostGroup: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: String?
    let isAdmin, isMember, isAdvertiser: Int?
    let photo50, photo100, photo200: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

// MARK: - Item
struct NewsPostItem: Codable {
    let sourceID, date: Int?
    let canDoubtCategory, canSetCategory: Bool?
    let postType, text: String?
    let markedAsAds: Int?
    let attachments: [NewsPostAttachment]?
    let postSource: NewsPostPostSource?
    let comments: NewsPostComments?
    let likes: NewsPostLikes?
    let reposts: NewsPostReposts?
    let views: NewsPostViews?
    let isFavorite: Bool?
    let donut: NewsPostDonut?
    let shortTextRate: Double?
    let postID: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts, views
        case isFavorite = "is_favorite"
        case donut
        case shortTextRate = "short_text_rate"
        case postID = "post_id"
        case type
    }
}

// MARK: - Attachment
struct NewsPostAttachment: Codable {
    let type: String?
    let photo: NewsPostPhoto?
    let link: NewsPostLink?
}

// MARK: - Link
struct NewsPostLink: Codable {
    let url: String?
    let title, caption, linkDescription: String?
    let photo: NewsPostPhoto?
    let isFavorite: Bool?

    enum CodingKeys: String, CodingKey {
        case url, title, caption
        case linkDescription = "description"
        case photo
        case isFavorite = "is_favorite"
    }
}

// MARK: - Photo
struct NewsPostPhoto: Codable {
    let albumID, date, id, ownerID: Int?
    let hasTags: Bool?
    let sizes: [NewsPostSize]?
    let text: String?
    let userID: Int?
    let accessKey: String?
    let postID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text
        case userID = "user_id"
        case accessKey = "access_key"
        case postID = "post_id"
    }
}

// MARK: - Size
struct NewsPostSize: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width: Int?
}

// MARK: - Comments
struct NewsPostComments: Codable {
    let count, canPost: Int?
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Donut
struct NewsPostDonut: Codable {
    let isDonut: Bool?

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct NewsPostLikes: Codable {
    let count, userLikes, canLike, canPublish: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - PostSource
struct NewsPostPostSource: Codable {
    let type: String?
    let platform: String?
}

// MARK: - Reposts
struct NewsPostReposts: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct NewsPostViews: Codable {
    let count: Int?
}

// MARK: - Profile
struct NewsPostProfile: Codable {
    let firstName: String?
    let id: Int?
    let lastName: String?
    let canAccessClosed, isClosed: Bool?
    let sex: Int?
    let screenName: String?
    let photo50, photo100: String?
    let onlineInfo: NewsPostOnlineInfo?
    let online: Int?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online
    }
}

// MARK: - OnlineInfo
struct NewsPostOnlineInfo: Codable {
    let visible, isOnline, isMobile: Bool?

    enum CodingKeys: String, CodingKey {
        case visible
        case isOnline = "is_online"
        case isMobile = "is_mobile"
    }
}
