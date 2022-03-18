//
//  FlowerDetailView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/18.
//

import SwiftUI
import Kingfisher
import Introspect

struct FlowerDetailView: View {
    @ObservedObject var viewModel = FlowerDetailViewModel()
    @State private var uiTabarController: UITabBarController?
    
    let no: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: viewModel.flower.imageUrls[0]))
                .resizable()
                .frame(width: UIFrame.width)
            
            VStack {
                Text(viewModel.flower.name)
                
                HStack {
                    Text("꽃말")
                    
                    Text(viewModel.flower.flowerLanguage)
                }
            }
        }
        .onAppear {
            viewModel.onAppear(no: no)
        }
        .introspectTabBarController { (UITabBarController) in
            UITabBarController.tabBar.isHidden = true
            uiTabarController = UITabBarController
        }.onDisappear{
            uiTabarController?.tabBar.isHidden = false
        }
    }
}

struct FlowerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerDetailView(no: 1)
    }
}
