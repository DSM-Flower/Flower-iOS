//
//  NewPostViewModel.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/23.
//

import SwiftUI

class NewPostViewModel: ObservableObject {
    @Published var nickname = ""
    @Published var password = ""
    @Published var content = ""
    @Published var image: Image?
    
    
}
