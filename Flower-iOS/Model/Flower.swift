//
//  Flower.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/16.
//

import Foundation
import SwiftyXMLParser

public struct Flower {
    let no: Int
    let name: String
    let scientificName: String
    let englishName: String
    let flowerLanguage: String
    let content: String
    let use: String
    let grow: String
    let type: String
    let imageUrls: [String]
    let publishOrg: String
    
    public init(no: Int,
         name: String,
         scientificName: String,
         englishName: String,
         flowerLanguage: String,
         content: String,
         use: String,
         grow: String,
         type: String,
         imageUrls: [String],
         publishOrg: String) {
        self.no = no
        self.name = name
        self.scientificName = scientificName
        self.englishName = englishName
        self.flowerLanguage = flowerLanguage
        self.content = content
        self.use = use
        self.grow = grow
        self.type = type
        self.imageUrls = imageUrls
        self.publishOrg = publishOrg
    }
    
    public init(_ accessor: XML.Accessor) {
        self.no = Int(accessor.dataNo.text!)!
        self.name = accessor.flowNm.text!
        self.scientificName = accessor.fSctNm.text ?? ""
        self.englishName = accessor.fEngNm.text ?? ""
        self.flowerLanguage = accessor.flowLang.text!
        self.content = accessor.fContent.element.toString()
        self.use = accessor.fUse.element.toString()
        self.grow = accessor.fGrow.element.toString()
        self.type = accessor.fType.element.toString()
        self.imageUrls = [accessor.imgUrl1.element.toString(), accessor.imgUrl2.element.toString(), accessor.imgUrl3.element.toString()]
        self.publishOrg = accessor.publishOrg.text!
    }
    
    static let Empty = Flower(no: 0, name: "", scientificName: "", englishName: "", flowerLanguage: "", content: "", use: "", grow: "", type: "", imageUrls: ["", "", ""], publishOrg: "")
}


extension Optional where Wrapped == XML.Element {
    func toString() -> String {
        switch self {
        case .some(let value):
            let data = value.CDATA ?? Data()
            return String(data: data, encoding: .utf8) ?? ""
        case _:
            return ""
        }
    }
}
