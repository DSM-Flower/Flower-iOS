//
//  Post.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/05/01.
//

import Foundation

public struct Post: Codable {
    var id: String
    var uploadDate: String
    var title: String
    var content: String
    var imageUrl: String
    var nickname: String
    var comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case uploadDate
        case title
        case content
        case imageUrl = "image"
        case nickname
        case comments = "comment"
    }
}
