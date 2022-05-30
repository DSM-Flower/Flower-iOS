//
//  File.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/05/12.
//

import Foundation
import SwiftUI
import Kingfisher

public struct FlowerImageView: View {
    private let url: String
    
    public init(id: String) {
        self.url = FlowerAPI.baseUrl + "/image?id=\(id)"
    }
    
    public var body: some View {
        Group {
            KFImage(URL(string: url))
                .placeholder {
                    Image("loading")
                        .resizable()
                }
                .resizable()
                .cornerRadius(10)
        }
    }
}
