//
//  CommentsRepository.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/05/18.
//

import Foundation
import Alamofire

public protocol CommentRepository {
    func createComment(postId: String, content: String, nickname: String, password: String, completion: @escaping (FlowerAPIResult) -> ())
    func modifyComment(id: String, content: String, nickname: String, password: String, completion: @escaping (FlowerAPIResult) -> ())
    func deleteComment(id: String, nickname: String, password: String, completion: @escaping (FlowerAPIResult) -> ())
}

public class CommentRepositoryImpl: CommentRepository {
    public init() {}
    
    public func createComment(postId: String, content: String, nickname: String, password: String, completion: @escaping (FlowerAPIResult) -> ()) {
        let url = FlowerAPI.baseUrl + FlowerAPI.createComment.path
        
        AF.upload(multipartFormData: { data in
            data.append(Data(postId.utf8), withName: "_id")
            data.append(Data(content.utf8), withName: "content")
            data.append(Data(nickname.utf8), withName: "nickname")
            data.append(Data(password.utf8), withName: "password")
        }, to: url, method: .post).responseData { response in
            guard let statusCode = response.response?.statusCode else { return }
            
            switch statusCode {
            case 200:
                completion(.success)
            default:
                print(statusCode)
                completion(.failure(error: CommentsError.serverError))
            }
        }
    }
    
    public func modifyComment(id: String, content: String, nickname: String, password: String, completion: @escaping (FlowerAPIResult) -> ()) {
        let url = FlowerAPI.baseUrl + FlowerAPI.modifyComment.path
        
        AF.upload(multipartFormData: { data in
            data.append(Data(id.utf8), withName: "_id")
            data.append(Data(content.utf8), withName: "content")
            data.append(Data(nickname.utf8), withName: "nickname")
            data.append(Data(password.utf8), withName: "password")
        }, to: url, method: .put).responseData { response in
            guard let statusCode = response.response?.statusCode else { return }
            
            switch statusCode {
            case 200:
                completion(.success)
            default:
                print(statusCode)
                completion(.failure(error: PostError.serverError))
            }
        }
    }
    
    public func deleteComment(id: String, nickname: String, password: String, completion: @escaping (FlowerAPIResult) -> ()) {
        var url = FlowerAPI.baseUrl + FlowerAPI.deleteComment(id: id, nickname: nickname, password: password).path
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        AF.request(url, method: .delete)
            .responseData { response in
                guard let statusCode = response.response?.statusCode else { return }
                
                switch statusCode {
                case 200:
                    completion(.success)
                default:
                    print(statusCode)
                    completion(.failure(error: PostError.serverError))
                }
            }
    }
}
