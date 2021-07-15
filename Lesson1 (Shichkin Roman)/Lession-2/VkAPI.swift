//
//  VK API.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 31.05.2021.
//

import Foundation
import Alamofire

private let baseUrl = "https://api.vk.com/method/"
private let version = "5.131"

// MARK: - Alamofire

func apiGetUserAF(userId: String)  {
    let path = "users.get"
    
    let parameters: Parameters = [
        "user_ids": userId,
        "fields": "bdate",
        "access_token": TokenAndIdService.shared.token,
        "v": version
    ]
    let url = baseUrl + path
    
    AF.request(url,
               method: .get,
               parameters: parameters
    ).responseData { response in
        guard let data = response.value else { return }
//        print(data.prettyJSON as Any)
    }
}

func apiFriendsListAF(completion: @escaping ([FriendsItem]) -> Void) {
    let path = "friends.get"
    
    let parameters: Parameters = [
        "user_ids": TokenAndIdService.shared.userId,
        "access_token": TokenAndIdService.shared.token,
        "order": "hints",
        "fields": "bdate,domain,photo_100",
        "count": "3",
        "v": version
    ]
    
    let url = baseUrl + path
    
    AF.request(url,
               method: .get,
               parameters: parameters
    ).responseData { response in
        guard let data = response.value else { return }
//                print(data.prettyJSON as Any)
        let usersList = try! JSONDecoder().decode(FriendsListFromAPI.self, from: data).response.items
        print(usersList as Any)
        completion(usersList)
    }
}

func apiUserPhotoAF(userId: String, completion: @escaping ([PhotoItem]) -> Void) {
    let path = "photos.getAll"
    
    let parameters: Parameters = [
        "owner_id": userId,
        "access_token": TokenAndIdService.shared.token,
        "extended": "1",
        "v": version
    ]
    
    let url = baseUrl + path
    
    AF.request(url,
               method: .get,
               parameters: parameters
    ).responseData { response in
        guard let data = response.value else { return }
        let userPhotos = try! JSONDecoder().decode(UserPhotosFromAPI.self, from: data).response.items
//        print(userPhotos as Any)
        completion(userPhotos)
    }
}

func apiUserGroupsAF(completion: @escaping ([GroupItem]) -> Void) {
    let path = "groups.get"
    
    let parameters: Parameters = [
        "user_ids": TokenAndIdService.shared.userId,
        "access_token": TokenAndIdService.shared.token,
        "extended": "1",
        "count": "3",
        "v": version
    ]
    let url = baseUrl + path
    
    AF.request(url,
               method: .get,
               parameters: parameters
    ).responseData { response in
        guard let data = response.value else { return }
        print(data.prettyJSON as Any)
        
        let userGroups = try! JSONDecoder().decode(UserGroupsFromAPI.self, from: data).response.items
//        print(userGroups as Any)
        completion(userGroups)
    }
}

func apiSearchGroupsAF(search: String) {
    let path = "groups.search"
    
    let parameters: Parameters = [
        "access_token": TokenAndIdService.shared.token,
        "q": search,
        "count": "3",
        "v": version
    ]
    let url = baseUrl + path
    
    AF.request(url,
               method: .get,
               parameters: parameters
    ).responseData { response in
        guard let data = response.value else { return }
//        print(data.prettyJSON as Any)
    }
}

func apiNewsFeedPostAF() {
    let path = "newsfeed.get"
    
    let parameters: Parameters = [
        "user_ids": TokenAndIdService.shared.userId,
        "access_token": TokenAndIdService.shared.token,
        "filters": "post",
        "count": "1",
        "v": version
    ]
    
    let url = baseUrl + path
    
    AF.request(url,
               method: .get,
               parameters: parameters
    ).responseData { response in
        guard let data = response.data else { return }
        print(data.prettyJSON as Any)
    }
}
