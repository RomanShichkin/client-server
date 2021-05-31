//
//  VK API.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 31.05.2021.
//

import Foundation

func apiGetUser(token: String, userId: String) {
    var friendsUrlComponents = URLComponents()
    friendsUrlComponents.scheme = "https"
    friendsUrlComponents.host = "api.vk.com"
    friendsUrlComponents.path = "/method/users.get"
    friendsUrlComponents.queryItems = [
        URLQueryItem(name: "user_ids", value: userId),
        URLQueryItem(name: "fields", value: "bdate"),
        URLQueryItem(name: "access_token", value: token),
        URLQueryItem(name: "v", value: "5.131")
    ]
    
    let request = URLRequest(url: friendsUrlComponents.url!)
    
    let give = URLSession.shared
    give.dataTask(with: request){ (data, response, error) in
        if let response = response {
            print("---------API USER-------------------------------------------------------")
            print(response)
        }
        
        guard let data = data else {return}
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        } catch {
            print(error)
        }
    }.resume()
}

func apiFriendsList(token: String, userId: String) {
    var friendsUrlComponents = URLComponents()
    friendsUrlComponents.scheme = "https"
    friendsUrlComponents.host = "api.vk.com"
    friendsUrlComponents.path = "/method/friends.get"
    friendsUrlComponents.queryItems = [
        URLQueryItem(name: "user_ids", value: userId),
        URLQueryItem(name: "access_token", value: token),
        URLQueryItem(name: "order", value: "hints"),
        URLQueryItem(name: "fields", value: "domain"),
        URLQueryItem(name: "count", value: "3"),
        URLQueryItem(name: "v", value: "5.131")
    ]
    
    let request = URLRequest(url: friendsUrlComponents.url!)
    
    let give = URLSession.shared
    give.dataTask(with: request)
    { (data, response, error) in
        if let response = response {
            print("---------API FRIENDS LIST-------------------------------------------------------")
            print(response)
        }

        guard let data = data else {return}

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        } catch {
            print(error)
        }
    }
        .resume()
}


func apiUserPhoto(token: String, userId: String) {
    var friendsUrlComponents = URLComponents()
    friendsUrlComponents.scheme = "https"
    friendsUrlComponents.host = "api.vk.com"
    friendsUrlComponents.path = "/method/photos.getAll"
    friendsUrlComponents.queryItems = [
        URLQueryItem(name: "owner_id", value: userId),
        URLQueryItem(name: "access_token", value: token),
        URLQueryItem(name: "extended", value: "1"),
        URLQueryItem(name: "v", value: "5.131")
    ]
    
    let request = URLRequest(url: friendsUrlComponents.url!)
    
    let give = URLSession.shared
    give.dataTask(with: request)
    { (data, response, error) in
        if let response = response {
            print("---------API USER PHOTO--------------------------------------------------------")
            print(response)
        }

        guard let data = data else {return}

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        } catch {
            print(error)
        }
    }
        .resume()
}

func apiUserGroups(token: String, userId: String) {
    var friendsUrlComponents = URLComponents()
    friendsUrlComponents.scheme = "https"
    friendsUrlComponents.host = "api.vk.com"
    friendsUrlComponents.path = "/method/groups.get"
    friendsUrlComponents.queryItems = [
        URLQueryItem(name: "owner_id", value: userId),
        URLQueryItem(name: "access_token", value: token),
        URLQueryItem(name: "extended", value: "1"),
        URLQueryItem(name: "count", value: "3"),
        URLQueryItem(name: "v", value: "5.131")
    ]
    
    let request = URLRequest(url: friendsUrlComponents.url!)
    
    let give = URLSession.shared
    give.dataTask(with: request)
    { (data, response, error) in
        if let response = response {
            print("---------API USER GROUPS-------------------------------------------------------")
            print(response)
        }

        guard let data = data else {return}

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        } catch {
            print(error)
        }
    }
        .resume()
}


func apiSearchGroups(token: String) {
    var friendsUrlComponents = URLComponents()
    friendsUrlComponents.scheme = "https"
    friendsUrlComponents.host = "api.vk.com"
    friendsUrlComponents.path = "/method/groups.search"
    friendsUrlComponents.queryItems = [
        URLQueryItem(name: "access_token", value: token),
        URLQueryItem(name: "q", value: "Music"),
        URLQueryItem(name: "count", value: "3"),
        URLQueryItem(name: "v", value: "5.131")
    ]
    
    let request = URLRequest(url: friendsUrlComponents.url!)
    
    let give = URLSession.shared
    give.dataTask(with: request)
    { (data, response, error) in
        if let response = response {
            print("---------API SEARCH GROUPS-------------------------------------------------------")
            print(response)
        }

        guard let data = data else {return}

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        } catch {
            print(error)
        }
    }
        .resume()
}
