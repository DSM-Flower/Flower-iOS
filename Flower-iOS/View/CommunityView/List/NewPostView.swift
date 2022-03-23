//
//  NewPostView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/23.
//

import SwiftUI

struct NewPostView: View {
    @ObservedObject var viewModel = NewPostViewModel()
    var body: some View {
        VStack {
            HStack {
                TextField("닉네임", text: $viewModel.nickname)
                TextField("비밀번호", text: $viewModel.password)
            }
        }
    }
}
