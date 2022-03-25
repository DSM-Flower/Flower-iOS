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
    @State private var isOpen = false
    
    let no: Int
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    KFImage(URL(string: viewModel.flower.imageUrls[0]))
                        .resizable()
                    
                    Color.black
                        .opacity(isOpen ? 0.5 : 0.0)
                        .animation(.easeInOut)
                }.frame(width: UIFrame.width - 20, height: UIFrame.width / 1.5)
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                VStack {
                    Color.black.frame(width: UIFrame.width / 8, height: 3)
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded({ value in
                                if value.translation.height < 0 {
                                    self.isOpen = true
                                } else if value.translation.height > 0 {
                                    self.isOpen = false
                                }
                            }))
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Text(viewModel.flower.name + viewModel.flower.englishName)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Flower"))
                                
                                Spacer()
                                
                                Text(viewModel.flower.scientificName)
                                    .foregroundColor(.gray.opacity(0.75))
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 10)
                                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray.opacity(0.1)))
                            }
                            
                            HStack(spacing: 10) {
                                Text("꽃말")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                
                                Text("|")
                                
                                Text(viewModel.flower.flowerLanguage)
                                
                                Spacer()
                            }
                        }.padding(.horizontal)
                        
                        Color.gray.frame(height: 5)
                            .padding(.vertical, 5)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("내용")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                
                                Text(" " + viewModel.flower.content)
                            }
                            
                            CustomDivider()
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("이용")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                
                                Text(" " + viewModel.flower.use)
                            }
                            
                            CustomDivider()
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("기르기")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                
                                Text(" " + viewModel.flower.grow)
                            }
                            
                            CustomDivider()
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("자생지")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                
                                Text(" " + viewModel.flower.type)
                            }
                            
                        }.padding(.horizontal)
                        
                    }
                }
                .animation(.interactiveSpring(), value: isOpen)
                .frame(height: self.isOpen ? UIFrame.height / 1.25 : UIFrame.height - UIFrame.width / 1.25)
                .background(Rectangle().cornerRadius(20, corners: [.topLeft, .topRight]).foregroundColor(.white).shadow(radius: 5))
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .navigationTitle("꽃 이름")
        .navigationBarTitleDisplayMode(.inline)
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
