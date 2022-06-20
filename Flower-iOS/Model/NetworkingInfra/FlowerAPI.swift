//
//  FlowerAPI.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/05/01.
//

import UIKit
import Alamofire

public enum FlowerAPI {
    // MARK: Image Search
    case getFlowerFromImage
    
    // MARK: Community
    case getCommunity(search: String)
    case getPost(id: String)
    case createPost
    case modifyPost
    case deletePost(id: String, nickname: String, password: String)
    
    // MARK: Comments
    case createComment
    case modifyComment
    case deleteComment(id: String, nickname: String, password: String)
}

extension FlowerAPI {
    public static let baseUrl = "http://184.169.191.128:5000"
    
    public var path: String {
        switch self {
        case .getFlowerFromImage:
            return "/flower_search"
            
            // MARK: Community
        case let .getCommunity(search: search):
            return "/community_search?keyword=\(search)"
        case let .getPost(id: id):
            return "/community?id=\(id)"
        case .createPost:
            return "/community"
        case .modifyPost:
            return "/community"
        case let .deletePost(id: id, nickname: nickname, password: password):
            return "/community?id=\(id)&nickname=\(nickname)&password=\(password)"
            
            // MARK: Comments
        case .createComment:
            return "/comment"
        case .modifyComment:
            return "/comment"
        case let .deleteComment(id: id, nickname: nickname, password: password):
            return "/comment?id=\(id)&nickname=\(nickname)&password=\(password)"
        }
    }
}
