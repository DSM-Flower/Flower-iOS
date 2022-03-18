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
            VStack {
                SearchBar(text: $viewModel.search, placeholder: "꽃말을 입력해주세요.")
                
                ScrollView {
                    NavigationLink(destination: LazyView(PostView())) {
                        CommunityRow()
                    }
                }
            }.padding(.horizontal, 10)
                .navigationTitle("커뮤니티")
                .introspectTabBarController { (UITabBarController) in
                    UITabBarController.tabBar.isHidden = false
                    uiTabarController = UITabBarController
                }
                .onAppear {
                    uiTabarController?.tabBar.isHidden = false
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
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("제목")
                    .font(.title3)
                    .foregroundColor(Color("Black"))
                
                Text("내용")
                    .font(.body)
                    .foregroundColor(Color("Black"))
                
                Text("날짜")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 50, height: 50)
        }
    }
}
