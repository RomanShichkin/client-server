//
//  DataStorage.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 14.04.2021.
//

import UIKit

class DataStorage: NSObject {
    static let shared = DataStorage()
    private override init() {
        super.init()
    }
    
    var usersArray = [User]()
    var groupedUsers = [String : [User]]()
    var userSections = [String]()
//    var myFriendsArray = [User]()
    var allGroups = [Group]()
    var myGroups = [Group]()
    var allNews = [News]()
}
