//
//  Comment.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/05/01.
//

import Foundation

public struct Comment: Codable {
    let id: String
    let content: String
    let nickname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content
        case nickname
    }
}
