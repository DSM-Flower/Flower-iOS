//
//  ContentView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FlowerPhotoView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("꽃 검색")
                }
            
            FlowerLanguageView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("꽃말 검색")
                }
            
            CommunityListView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("커뮤니티")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
