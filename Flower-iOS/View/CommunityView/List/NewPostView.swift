//
//  NewPostView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/23.
//

import SwiftUI
import Introspect

struct NewPostView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel = NewPostViewModel()
    @State private var uiTabarController: UITabBarController?
    @State private var isShowPhotoLibrary = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    TextField("닉네임", text: $viewModel.nickname)
                        .textFieldStyle(.roundedBorder)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("White")).shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 4))
                    
                    SecureField("비밀번호", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("White")).shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 4))
                }
                
                VStack {
                    TextField("제목", text: $viewModel.title)
                        .textFieldStyle(.roundedBorder)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("White")).shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 4))
                    
                    TextView(text: $viewModel.content, placeholder: "내용을 입력해주세요.")
                        .frame(height: UIFrame.height / 3.5)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("White")).shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 4))
                }
                
                HStack {
                    if viewModel.selectedImage == nil {
                        VStack(spacing: 10) {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 50, height: 40)
                            Text("사진 선택")
                        }.foregroundColor(.gray)
                            .frame(width: UIFrame.width / 2.2, height: UIFrame.width / 2.2)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("White")).shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 4))
                            .onTapGesture {
                                self.isShowPhotoLibrary = true
                            }
                    } else {
                        Image(uiImage: viewModel.selectedImage!)
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: UIFrame.width / 2.2, height: UIFrame.width / 2.2)
                            .shadow(radius: 5)
                            .onTapGesture {
                                self.isShowPhotoLibrary = true
                            }
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }.padding()
            
            VStack {
                Spacer()
                
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("Flower"))
                        .frame(width: UIFrame.width - 30, height: 40)
                    
                    Text("작성하기")
                        .foregroundColor(Color("White"))
                }.onTapGesture {
                    viewModel.createPost()
                }
            }
        }
        .navigationTitle("작성하기")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $viewModel.selectedImage)
        }
        .onAppear {
            self.viewModel.onAppear(viewCloseAction: {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
        .introspectTabBarController { (UITabBarController) in
            UITabBarController.tabBar.isHidden = true
            uiTabarController = UITabBarController
        }.onDisappear {
            uiTabarController?.tabBar.isHidden = false
        }
    }
}
