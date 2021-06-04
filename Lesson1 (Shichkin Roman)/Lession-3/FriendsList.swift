//
//  FriendsList2.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 03.06.2021.
//

import Foundation

// MARK: - FriendsListFromAPI
struct FriendsListFromAPI: Codable {
    let response: FriendsResponse
}

// MARK: - Response
struct FriendsResponse: Codable {
    let count: Int
    let items: [FriendsItem]
}

// MARK: - Item
struct FriendsItem: Codable {
    let canAccessClosed: Bool
    let domain, bdate: String
    let id: Int
    let photo100: String
    let lastName, trackCode: String
    let isClosed: Bool
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case domain, bdate, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case trackCode = "track_code"
        case isClosed = "is_closed"
        case firstName = "first_name"
    }
}

