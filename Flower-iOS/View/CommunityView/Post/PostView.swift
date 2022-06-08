//
//  PostView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/18.
//

import SwiftUI
import Introspect

struct PostView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel = PostViewModel()
    @State private var isDeleteAlert = false
    @State private var isModifing = false
    @State private var isModifyAlert = false
    
    let id: String
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Spacer()
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        ScrollView(.horizontal) {
                            ForEach(viewModel.post.image, id: \.self) { image in
                                FlowerImageView(id: image)
                                    .frame(width: UIFrame.width - 30, height: UIFrame.width / 1.5)
                            }
                        }
                        
                        if isModifing {
                            TextView(text: $viewModel.modifiedContent, placeholder: viewModel.post.content)
                                .frame(height: UIFrame.height / 3.5)
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("White")).shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 4))
                        } else {
                            Text(viewModel.post.content)
                        }
                    }
                    
                    Spacer()
                }
            }
            
            VStack {
                Spacer()
                
                if isModifing {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("Flower"))
                            .frame(width: UIFrame.width - 30, height: 40)
                        
                        Text("수정하기")
                            .foregroundColor(Color("White"))
                    }.padding(.bottom, UIFrame.width / 9)
                    .onTapGesture {
                        self.isModifyAlert = true
                        self.isModifing = false
                    }
                } else {
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: LazyView(CommentsView(postId: id))) {
                            HStack(alignment: .top) {
                                Text("\(viewModel.post.comments.count)")
                                    .foregroundColor(Color("Black"))
                                
                                Image(systemName: "message")
                            }.padding(.horizontal)
                        }
                    }.padding(.top, 10)
                        .padding(.bottom, UIFrame.width / 9)
                        .background(Rectangle().foregroundColor(.white).shadow(radius: 5))
                }
            }
        }.ignoresSafeArea(.all, edges: .bottom)
            .navigationTitle(viewModel.post.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isModifing = true
                    }, label: {
                        Image(systemName: "square.and.pencil")
                    })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isDeleteAlert = true
                    }, label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    })
                }
            }
            .textFieldAlert(isPresented: $isModifyAlert) { () -> TextFieldAlert in
                TextFieldAlert(title: "수정을 위한 비밀번호를 입력해주세요.", textFieldType: .single, action: viewModel.modifyPost, password: self.$viewModel.prevPassword, modifyString: self.$viewModel.deletePostTitle)
            }
            .textFieldAlert(isPresented: $isDeleteAlert) { () -> TextFieldAlert in
                TextFieldAlert(title: "글 삭제", textFieldType: .delete, action: viewModel.deletePost, password: self.$viewModel.prevPassword, modifyString: self.$viewModel.deletePostTitle)
            }
            .toast(message: viewModel.errorMessage,
                   isShowing: $viewModel.showErrorToast)
            .introspectTabBarController { (UITabBarController) in
                UITabBarController.tabBar.isHidden = true
            }
            .onAppear {
                self.viewModel.onAppear(id: id, viewCloseAction: {
                    self.presentationMode.wrappedValue.dismiss()
                })
            }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(id: "627cc1ac454d90856eca9edc")
    }
}
