//
//  NewsPost.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 14.07.2021.
//

import Foundation

// MARK: - NewsPostFromAPI
struct NewsPostFromAPI: Codable {
    let response: NewsPostResponse
}

// MARK: - Response
struct NewsPostResponse: Codable {
    let items: [NewsPostItem]
    let groups: [NewsPostGroup]
    let profiles: [NewsPostProfile]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct NewsPostGroup: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type, screenName, name: String
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

// MARK: - Item
struct NewsPostItem: Codable {
    let donut: Donut
    let comments: NewsPostComments
    let canSetCategory, isFavorite: Bool
    let shortTextRate: Double
    let likes: NewsPostLikes
    let reposts: NewsPostReposts
    let type, postType: String
    let date, sourceID: Int
    let text: String
    let canDoubtCategory: Bool
    let attachments: [NewsPostAttachment]
    let markedAsAds, postID: Int
    let postSource: PostSource
    let views: Views

    enum CodingKeys: String, CodingKey {
        case donut, comments
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case shortTextRate = "short_text_rate"
        case likes, reposts, type
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case attachments
        case markedAsAds = "marked_as_ads"
        case postID = "post_id"
        case postSource = "post_source"
        case views
    }
}

// MARK: - Attachment
struct NewsPostAttachment: Codable {
    let type: String
    let photo: NewsPostPhoto
}

// MARK: - Photo
struct NewsPostPhoto: Codable {
    let albumID, postID, id, date: Int
    let text: String
    let userID: Int
    let sizes: [NewsPostPhotoSize]
    let hasTags: Bool
    let ownerID: Int
    let accessKey: String

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case postID = "post_id"
        case id, date, text
        case userID = "user_id"
        case sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case accessKey = "access_key"
    }
}

// MARK: - Size
struct NewsPostPhotoSize: Codable {
    let width, height: Int
    let url: String
    let type: String
}

// MARK: - Comments
struct NewsPostComments: Codable {
    let count, canPost: Int

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct NewsPostLikes: Codable {
    let canLike, canPublish, count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String
}

// MARK: - Reposts
struct NewsPostReposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - Profile
struct NewsPostProfile: Codable {
    let canAccessClosed: Bool
    let screenName: String
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let isClosed: Bool
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case screenName = "screen_name"
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case isClosed = "is_closed"
        case firstName = "first_name"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
    }
}

