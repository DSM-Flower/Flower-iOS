//
//  OpenAPIReposisory.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/16.
//

import Foundation
import Alamofire
import SwiftyXMLParser

public class OpenAPIRepository {
    public init() {}
    
    public func getFlowerList(type: OpenAPI.SearchType, word: String, completion: @escaping ([Flower]) -> ()) {
        var url = OpenAPI.baseUrl.search.rawValue
        url += "&searchType=" + String(type.rawValue)
        url += "&searchWord=" + word
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        url += "&ServiceKey=" + OpenAPI.serviceKey
        
        self.parseJson(from: url, completion: completion)
    }
    
    public func getFlower(dataNo: Int, completion: @escaping ([Flower]) -> ()) {
        var url = OpenAPI.baseUrl.item.rawValue
        url += "&dataNo=" + String(dataNo)
        
        self.parseJson(from: url, completion: completion)
    }
    
    private func parseJson(from url: String, completion: @escaping ([Flower]) -> ()) {
        var flowers = [Flower]()
        AF.request(url, method: .get)
            .responseData { response in
                if let data = response.data {
                    let xml = XML.parse(data)
                    let flowersCount = xml.document.root.resultCnt.text
                    
                    if flowersCount != nil {
                        for i in 0..<Int(flowersCount!)! {
                            flowers.append(Flower(xml.document.root.result[i]))
                        }
                        completion(flowers)
                    }
                }
                completion(flowers)
            }
    }
}
