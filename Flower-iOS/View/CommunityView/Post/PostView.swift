//
//  PostView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/18.
//

import SwiftUI
import Introspect

struct PostView: View {
    @ObservedObject var viewModel = PostViewModel()
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: UIFrame.width - 20, height: UIFrame.width - 20)
            
            Text("내용")
            
            Spacer()
            
            NavigationLink(destination: LazyView(CommentsView())) {
                HStack {
                    Spacer()
                    
                    Text("댓글 수")
                        .foregroundColor(Color("Black"))
                }
            }
        }.navigationTitle("제목")
            .navigationBarTitleDisplayMode(.inline)
            .introspectTabBarController { (UITabBarController) in
                UITabBarController.tabBar.isHidden = true
            }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
