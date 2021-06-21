//
//  GroupsID.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 21.06.2021.
//

import Foundation
import Firebase

 class GroupsID {

    let groupsID: [String]
     let ref: DatabaseReference?

     init(groupsID: [String]) {
         self.ref = nil
         self.groupsID = groupsID
     }

     init?(snapshot: DataSnapshot) {
         guard
             let value = snapshot.value as? [String: Any],
             let groupsID = value["groupID"] as? [String] else {
             return nil
         }

         self.ref = snapshot.ref
         self.groupsID = groupsID
     }

     func toAnyObject() -> [AnyHashable: Any] {
         return [ "groupID": groupsID ] as [AnyHashable: Any]
     }
 }
