//
//  UserID.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 21.06.2021.
//

import Foundation
import Firebase

 class UserID {

     let userID: String
     let ref: DatabaseReference?

     init(userID: String) {
         self.ref = nil
         self.userID = userID
     }

     init?(snapshot: DataSnapshot) {
         guard
             let value = snapshot.value as? [String: Any],
             let userID = value["userID"] as? String else {
             return nil
         }

         self.ref = snapshot.ref
         self.userID = userID
     }

     func toAnyObject() -> [AnyHashable: Any] {
         return [ "userID": userID ] as [AnyHashable: Any]
     }
 }
