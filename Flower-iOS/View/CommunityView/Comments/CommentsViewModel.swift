//
//  CommentsViewModel.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/18.
//

import Foundation

class CommentsViewModel: ObservableObject {
    @Published var newNickname = ""
    @Published var newPassword = ""
    @Published var newComment = ""
}
