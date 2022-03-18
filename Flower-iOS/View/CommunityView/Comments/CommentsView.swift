//
//  CommentsView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/18.
//

import SwiftUI
import Introspect

struct CommentsView: View {
    @ObservedObject var viewModel = CommentsViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                CommentRow()
            }
        }.navigationTitle("댓글")
        .introspectTabBarController { (UITabBarController) in
            UITabBarController.tabBar.isHidden = true
        }
    }
}

struct CommentRow: View {
    var body: some View {
        HStack {
            VStack {
                Text("닉네임")
                
                Text("댓글내용")
            }
            
            Spacer()
            
            VStack {
                // image
                
                Spacer()
            }
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
