//
//  FlowerAPIRepository.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/05/01.
//

import Foundation
import Alamofire

public protocol FlowerAPIRepository {
    func getCommunity(search: String, completion: @escaping ([Post]) -> ())
    func getPost(id: String, completion: @escaping (Post) -> ())
    func getImageData(url: String) -> Data?
}

public class FlowerAPIRepositoryImpl: FlowerAPIRepository {
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
    
    public func getPost(id: String, completion: @escaping (Post) -> ()) {
        var url = FlowerAPI.baseUrl + FlowerAPI.getPost(id: id).path
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        var post = Post.EMPTY
        
        AF.request(url, method: .get)
            .responseData { response in
                if let data = response.data {
                    do {
                        post = try JSONDecoder().decode(Post.self, from: data)
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
    
    public func getImageData(url: String) -> Data? {
        var result: Data?
        
        AF.request(url, method: .get)
            .responseData { response in
                if let data = response.data {
                    result = data
                }
            }
        
        return result
    }
}
