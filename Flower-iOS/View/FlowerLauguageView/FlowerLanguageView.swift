//
//  FlowerLanguageView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/16.
//

import SwiftUI
import Kingfisher

struct FlowerLanguageView: View {
    @ObservedObject var viewModel = FlowerLanguageViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                SearchBar(text: $viewModel.search, placeholder: "꽃말을 입력해주세요.")
                
                ScrollView {
                    ForEach(viewModel.flowers, id: \.no) { flower in
                        NavigationLink(destination: LazyView(FlowerDetailView(no: flower.no))) {
                            VStack(spacing: 10) {
                                FlowerRow(flower: flower)
                                
                                if flower.no != viewModel.flowers.last?.no {
                                    CustomDivider()
                                }
                            }.padding(.horizontal, 10)
                                .padding(.top, 5)
                        }
                    }
                }
            }.padding(.horizontal, 10)
                .navigationTitle("꽃말 검색")
        }
        .navigationViewStyle(.stack)
    }
}

struct FlowerLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerLanguageView()
    }
}
