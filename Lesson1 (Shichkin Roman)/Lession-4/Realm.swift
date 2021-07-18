//
//  FriendsList2.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 06.06.2021.
//

import Foundation
import RealmSwift

private let schemaVersion :UInt64 = 4
private let config = Realm.Configuration(schemaVersion: schemaVersion)

// MARK: - FriendsREALM

class FriendsRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var photo100 = ""
    @objc dynamic var bdate: String?
    @objc dynamic var domain = ""
    @objc dynamic var trackCode = ""
    override static func primaryKey() -> String? {
            return "id"
        }
}

func saveFriendsRealm(friendsItemArray: [FriendsItem]) {
    for friendsItem in friendsItemArray {
        do {
            let frndRlm = FriendsRealm()
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            frndRlm.id = friendsItem.id
            frndRlm.firstName = friendsItem.firstName
            frndRlm.lastName = friendsItem.lastName
            frndRlm.photo100 = friendsItem.photo100
            frndRlm.bdate = friendsItem.bdate
            frndRlm.trackCode = friendsItem.trackCode
            realm.add(frndRlm, update: Realm.UpdatePolicy.modified)
            try realm.commitWrite()
            print(realm.configuration.fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}

func loadFriendsRealm() {
    do {
        let realm = try Realm(configuration: config)
        let friends = realm.objects(FriendsRealm.self)
//        print(friends.map { $0.firstName })
    } catch  {
        print(error.localizedDescription)
    }
}

func readFriendsRealm() -> [FriendsRealm] {
    do {
        let realm = try Realm(configuration: config)
        let friends = realm.objects(FriendsRealm.self)
//        print(friends.map { $0.firstName })
        return Array(friends)
    } catch  {
        print(error.localizedDescription)
        return []
    }
}

func readFriendsRealmNotif() -> Results<FriendsRealm>? {
    do {
        let realm = try Realm(configuration: config)
        let friends = realm.objects(FriendsRealm.self)
        return friends
    } catch  {
        print(error.localizedDescription)
        return nil
    }
}



// MARK: - GroupsREALM

class GroupsRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var screenName = ""
    @objc dynamic var photo100 = ""
    override static func primaryKey() -> String? {
            return "id"
        }
}

func saveGroupsRealm(groupsItemArray: [GroupItem]) {
    for groupsItem in groupsItemArray {
        do {
            let grpRlm = GroupsRealm()
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            grpRlm.id = groupsItem.id
            grpRlm.name = groupsItem.name
            grpRlm.screenName = groupsItem.screenName
            grpRlm.photo100 = groupsItem.photo100
            realm.add(grpRlm, update: Realm.UpdatePolicy.modified)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
}

func loadGroupsRealm() {
    do {
        let realm = try Realm(configuration: config)
        let friends = realm.objects(GroupsRealm.self)
//        print(friends.map { $0.name })
    } catch  {
        print(error.localizedDescription)
    }
}

func readGroupsRealm() -> [GroupsRealm] {
    do {
        let realm = try Realm(configuration: config)
        let groups = realm.objects(GroupsRealm.self)
//        print(groups.map { $0.name })
        return Array(groups)
    } catch  {
        print(error.localizedDescription)
        return []
    }
}

func readGroupsRealmNotif() -> Results<GroupsRealm>? {
    do {
        let realm = try Realm(configuration: config)
        let groups = realm.objects(GroupsRealm.self)
        return groups
    } catch  {
        print(error.localizedDescription)
        return nil
    }
}
