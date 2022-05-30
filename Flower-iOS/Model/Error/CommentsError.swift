//
//  CommentError.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/05/18.
//

import Foundation

public enum CommentsError: FlowerAPIError {
    case noContent
    case notMatchedPassword
    
    case serverError
}
