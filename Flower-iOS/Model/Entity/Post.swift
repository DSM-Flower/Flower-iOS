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
    var image: String?
    var nickname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case uploadDate
        case title
        case content
        case image
        case nickname
    }
    
    static let EMPTY = Post(id: "", uploadDate: "", title: "", content: "", nickname: "")
}
