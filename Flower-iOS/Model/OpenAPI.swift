//
//  OpenAPI.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/16.
//

import Foundation

public struct OpenAPI {
    public static let serviceKey = "VbPu11HKfsxXAEemWKQKclruJcEvTa5%2FQ9RwiMdSn1pVfNCTygoRKgybnA6jaD3DSf%2BES9YP2UzoEPxQ0h8gCA%3D%3D"
    
    public enum baseUrl: String {
        case search = "http://apis.data.go.kr/1390804/NihhsTodayFlowerInfo01/selectTodayFlowerList01?&numOfRows=100"
        case item = "http://apis.data.go.kr/1390804/NihhsTodayFlowerInfo01/selectTodayFlowerView01?"
    }
    
    public enum SearchType: Int {
        case name = 1
        case flowerLanguage = 4
    }
}
