//
//  ImageSearchRepository.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/06/15.
//

import Foundation
import Alamofire

public protocol ImageSearchRepository {
    func getFlower(image: Data, completion: @escaping ([Flower]) -> ())
}

public class ImageSearchRepositoryImpl: ImageSearchRepository {
    private let openAPIRepository: OpenAPIRepository
    
    public init(openAPIRepository: OpenAPIRepository = OpenAPIRepositoryImpl()) {
        self.openAPIRepository = openAPIRepository
    }
    
    public func getFlower(image: Data, completion: @escaping ([Flower]) -> ()) {
        let flowers = [Flower]()
        
        self._getFlower(image: image, completion: {
            if $0 == FlowerImageResponse.ERROR {
                completion(flowers)
            } else {
                var searchType: OpenAPI.SearchType = .name
                
                if $0.cls == 2 {
                    searchType = .flowerLanguage
                }
                
                self.openAPIRepository.getFlowerList(type: searchType, word: $0.name, completion: {
                    completion($0)
                })
            }
        })
    }
    
    private func _getFlower(image: Data, completion: @escaping (FlowerImageResponse) -> ()) {
        var result = FlowerImageResponse.ERROR
        
        let url = FlowerAPI.baseUrl + FlowerAPI.getFlowerFromImage.path
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { data in
            data.append(image, withName: "image", fileName: "\(image.count).jpeg", mimeType: "image/jpeg")
        }, to: url, method: .post, headers: headers).responseData { response in
            
            if let data = response.data {
                do {
                    result = try JSONDecoder().decode(FlowerImageResponse.self, from: data)
                    completion(result)
                } catch {
                    print(String(describing: error))
                    completion(result)
                }
            }
        }
    }
}
