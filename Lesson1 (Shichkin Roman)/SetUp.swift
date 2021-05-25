//
//  SetUp.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 14.04.2021.
//

import Foundation
import UIKit

func setNewUser(name: String, age: UInt) -> User {
    var user = User(name: name)
    user.age = age
    
    var imageName = name + "_1"
    user.avatar = UIImage(named: imageName)
    
    for index in 2...5 {
        imageName = name + "_" + String(index)
        if let image = UIImage(named: imageName) {
            user.fotoArray.append(image)
        }
    }
    return user
}
