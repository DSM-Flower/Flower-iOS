//
//  FlowerAPI.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/05/01.
//

import UIKit
import Alamofire

public enum AuthApi {
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

extension AuthApi {
    public static let baseUrl = "3.101.139.37"
    
    public var path: String {
        switch self {
        // Auth
        case .getCommunity:
            return "/community_search"
        case .getPost:
            return "/community"
        case .createPost:
            return "community"
        case .modifyPost:
            return "community"
        case .deletePost(id: let id, nickname: let nickname, password: let password):
            return "community?id=\(id)&nickname\(nickname)&password=\(password)"
        case .createComment:
            return "comment_post"
        case .modifyComment:
            return ""
        case .deleteComment(id: let id, nickname: let nickname, password: let password):
            return ""
        }
    }
}
