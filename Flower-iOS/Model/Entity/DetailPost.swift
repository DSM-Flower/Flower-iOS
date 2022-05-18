//
//  DetailPot.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/05/18.
//

import Foundation

public struct DetailPost: Codable {
    var id: String
    var uploadDate: String
    var title: String
    var content: String
    var image: [String]
    var nickname: String
    var password: String?
    var comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case uploadDate
        case title
        case content
        case image
        case nickname
        case password
        case comments = "comment"
    }
    
    static let EMPTY = DetailPost(id: "", uploadDate: "", title: "", content: "", image: [], nickname: "", comments: [])
}
