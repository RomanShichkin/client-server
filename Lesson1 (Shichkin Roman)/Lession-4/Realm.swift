//
//  FriendsList2.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 06.06.2021.
//

import Foundation
import RealmSwift

// MARK: - FriendsREALM

class FriendsRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var photo100 = ""
    @objc dynamic var bdate: String?
    @objc dynamic var domain = ""
    @objc dynamic var trackCode = ""
}

func saveFriendsRealm(friendsItemArray: [FriendsItem]) {
    for friendsItem in friendsItemArray {
        do {
            let frndRlm = FriendsRealm()
            let realm = try Realm()
            realm.beginWrite()
            frndRlm.id = friendsItem.id
            frndRlm.firstName = friendsItem.firstName
            frndRlm.lastName = friendsItem.lastName
            frndRlm.photo100 = friendsItem.photo100
            frndRlm.bdate = friendsItem.bdate
            frndRlm.trackCode = friendsItem.trackCode
            realm.add(frndRlm)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}

func loadFriendsRealm() {
    do {
        let realm = try Realm()
        let friends = realm.objects(FriendsRealm.self)
        print(friends.map { $0.firstName })
    } catch  {
        print(error)
    }
}


// MARK: - GroupsREALM

class GroupsRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var screenName = ""
    @objc dynamic var photo100 = ""

}

func saveGroupsRealm(groupsItemArray: [GroupItem]) {
    for groupsItem in groupsItemArray {
        do {
            let grpRlm = GroupsRealm()
            let realm = try Realm()
            realm.beginWrite()
            grpRlm.id = groupsItem.id
            grpRlm.name = groupsItem.name
            grpRlm.screenName = groupsItem.screenName
            grpRlm.photo100 = groupsItem.photo100
            realm.add(grpRlm)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}

func loadGroupsRealm() {
    do {
        let realm = try Realm()
        let friends = realm.objects(GroupsRealm.self)
        print(friends.map { $0.name })
    } catch  {
        print(error)
    }
}
