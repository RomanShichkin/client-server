//
//  SaveRealmOperation.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 18.07.2021.
//

import Foundation

class SaveRealmOperation: AsyncOperation {

    private(set) var item: [FriendsItem] = []
    
    override func main() {
        guard (self.dependencies.first as? GetDataOperation) != nil
        else {
            return
        }
        saveFriendsRealm(friendsItemArray: item)
    }
    
    init(item: [FriendsItem]) {
        self.item = item
    }
    
}
