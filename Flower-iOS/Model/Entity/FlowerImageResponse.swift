//
//  FlowerImageResponse.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/06/15.
//

import Foundation

public struct FlowerImageResponse: Codable, Equatable {
    var name: String
    var cls: Int
    
    static let ERROR = FlowerImageResponse(name: "0", cls: 0)
}
