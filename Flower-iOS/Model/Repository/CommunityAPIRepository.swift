//
//  CommunityAPIRepository.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/05/18.
//

import Foundation
import Alamofire

public protocol CommunityRepository {
    func getCommunity(search: String, completion: @escaping ([Post]) -> ())
    func getDetailPost(id: String, completion: @escaping (DetailPost) -> ())
    func createPost(title: String, content: String, images: [Data], nickname: String, password: String, completion: @escaping (FlowerAPIResult) -> ())
    func modifyPost(id: String, title: String, content: String, images: [Data], nickname: String, password: String, completion: @escaping (FlowerAPIResult) -> ())
    func deletePost(id: String, nickname: String, password: String, completion: @escaping (FlowerAPIResult) -> ())
    
    func getImageData(id: String, completion: @escaping (Data?) -> ())
}

public class CommunityRepositoryImpl: CommunityRepository {
    public init() {}
    
    public func getCommunity(search: String, completion: @escaping ([Post]) -> ()) {
        var url = FlowerAPI.baseUrl + FlowerAPI.getCommunity(search: search).path
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        var posts = [Post]()
        
        AF.request(url, method: .get)
            .responseData { response in
                if let data = response.data {
                    do {
                        posts = try JSONDecoder().decode([Post].self, from: data)
                        completion(posts)
                    } catch {
                        print(String(describing: error))
                        completion(posts)
                    }
                }
                completion(posts)
            }
    }
    
    public func getDetailPost(id: String, completion: @escaping (DetailPost) -> ()) {
        var url = FlowerAPI.baseUrl + FlowerAPI.getPost(id: id).path
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        var post = DetailPost.EMPTY
        
        AF.request(url, method: .get)
            .responseData { response in
                if let data = response.data {
                    do {
                        post = try JSONDecoder().decode(DetailPost.self, from: data)
                        completion(post)
                    } catch {
                        print(String(describing: error))
                        completion(post)
                    }
                }
                completion(post)
            }
        
        completion(post)
    }
    
    public func createPost(title: String, content: String, images: [Data], nickname: String, password: String, completion: @escaping (FlowerAPIResult) -> ()) {
        let url = FlowerAPI.baseUrl + FlowerAPI.createPost.path
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { data in
            data.append(Data(title.utf8), withName: "title")
            for image in images {
                data.append(image, withName: "image", fileName: "\(title).jpeg", mimeType: "image/jpeg")
            }
            data.append(Data(content.utf8), withName: "content")
            data.append(Data(nickname.utf8), withName: "nickname")
            data.append(Data(password.utf8), withName: "password")
        }, to: url, method: .post, headers: headers).responseData { response in
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
    
    public func modifyPost(id: String, title: String, content: String, images: [Data], nickname: String, password: String, completion: @escaping (FlowerAPIResult) -> ()) {
        let url = FlowerAPI.baseUrl + FlowerAPI.modifyPost.path
        
        AF.upload(multipartFormData: { data in
            data.append(Data(id.utf8), withName: "_id")
            data.append(Data(title.utf8), withName: "title")
            for image in images {
                data.append(image, withName: "image", fileName: "\(title).jpeg", mimeType: "image/jpeg")
            }
            data.append(Data(content.utf8), withName: "content")
            data.append(Data(nickname.utf8), withName: "nickname")
            data.append(Data(password.utf8), withName: "password")
        }, to: url, method: .put).responseData { response in
            guard let statusCode = response.response?.statusCode else { return }
            
            switch statusCode {
            case 200:
                completion(.success)
            default:
                completion(.failure(error: PostError.serverError))
            }
        }
    }
    
    public func deletePost(id: String, nickname: String, password: String, completion: @escaping (FlowerAPIResult) -> ()) {
        var url = FlowerAPI.baseUrl + FlowerAPI.deletePost(id: id, nickname: nickname, password: password).path
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
    
    public func getImageData(id: String, completion: @escaping (Data?) -> ()) {
        let url = FlowerAPI.baseUrl + "/image?id=\(id)"
        
        AF.request(url, method: .get)
            .responseData { response in
                if let data = response.data {
                    completion(data)
                }
                completion(nil)
            }
    }
}
