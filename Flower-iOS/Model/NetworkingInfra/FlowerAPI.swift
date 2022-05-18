//
//  FlowerAPI.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/05/01.
//

import UIKit
import Alamofire

public enum FlowerAPI {
    // MARK: Community
    case getCommunity(search: String)
    case getPost(id: String)
    case createPost(title: String, content: String, image: UIImage?, nickname: String, password: String)
    case modifyPost(id: String, title: String, content: String, image: UIImage?, nickname: String, password: String)
    case deletePost(id: String, nickname: String, password: String)
    
    // MARK: Comments
    case createComment(postId: String, content: String, nickname: String, password: String)
    case modifyComment(postId: String, content: String, nickname: String, password: String)
    case deleteComment(id: String, nickname: String, password: String)
}

extension FlowerAPI {
    public static let baseUrl = "http://54.153.89.152:5000"
    
    public var path: String {
        switch self {
        // Auth
        case let .getCommunity(search: search):
            return "/community_search?keyword=\(search)"
        case let .getPost(id: id):
            return "/community?id=\(id)"
        case .createPost:
            return "community"
        case .modifyPost:
            return "community"
        case let .deletePost(id: id, nickname: nickname, password: password):
            return "community?id=\(id)&nickname\(nickname)&password=\(password)"
        case .createComment:
            return "comment_post"
        case .modifyComment:
            return ""
        case let .deleteComment(id: id, nickname: nickname, password: password):
            return ""
        }
    }
}
