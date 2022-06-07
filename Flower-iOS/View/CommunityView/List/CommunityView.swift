//
//  CommunityView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/16.
//

import SwiftUI
import Introspect

struct CommunityListView: View {
    @ObservedObject var viewModel = CommunityViewModel()
    @State private var uiTabarController: UITabBarController?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                SearchBar(text: $viewModel.search, placeholder: "꽃명을 입력해주세요.")
                
                ScrollView {
                    ForEach(viewModel.posts, id: \.id) { post in
                        NavigationLink(destination: LazyView(PostView(id: post.id))) {
                            VStack(spacing: 10) {
                                CommunityRow(post: post)
                                
                                if post.id != viewModel.posts.last?.id {
                                    CustomDivider()
                                }
                            }.padding(.horizontal, 10)
                                .padding(.top, 5)
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
            .navigationTitle("커뮤니티")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: LazyView(NewPostView())) {
                        Image(systemName: "plus.app").foregroundColor(Color("Black"))
                    }
                }
            }
            .introspectTabBarController { (UITabBarController) in
                UITabBarController.tabBar.isHidden = false
                uiTabarController = UITabBarController
            }
            .onAppear {
                uiTabarController?.tabBar.isHidden = false
                self.viewModel.onAppear()
            }
        }.navigationViewStyle(.stack)
    }
}

struct CommunityListView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityListView()
    }
}

struct CommunityRow: View {
    let post: Post
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.title3)
                    .foregroundColor(Color("Black"))
                
                Text(post.content)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                
                HStack {
                    Spacer()
                    
                    Text(post.uploadDate)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }.padding(.horizontal, 10)
            
            Spacer()
            
            if post.image != nil {
                FlowerImageView(id: post.image!)
                    .frame(width: UIFrame.width / 6, height: UIFrame.width / 6)
            }
        }
    }
}
