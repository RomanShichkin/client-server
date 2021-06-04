//
//  Token.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 25.05.2021.
//

import Foundation

final class TokenAndIdService {
    
    private init() {}
    
    static let shared = TokenAndIdService()
    
    var token: String = ""
    var userId: String = ""
}
