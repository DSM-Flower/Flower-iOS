//
//  CommentsView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/18.
//

import SwiftUI
import Introspect

struct CommentsView: View {
    @StateObject var viewModel = CommentsViewModel()
    @State private var isDeleteAlert = false
    @State private var isModifyAlert = false
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    let postId: String
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(viewModel.comments, id: \.id) { comment in
                        CommentRow(comment: comment)
                            .swipeActions {
                                Button("수정") {
                                    self.viewModel.selectedComment = comment
                                    self.viewModel.modifiedComment = comment.content
                                    self.isModifyAlert = true
                                }.tint(.yellow)

                                Button("삭제") {
                                    self.viewModel.selectedComment = comment
                                    self.isDeleteAlert = true
                                }.tint(.red)
                            }
                    }
                }.listStyle(.plain)
            }
            
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    HStack {
                        UnderScoreTextField(placeholder: "닉네임", text: $viewModel.newNickname)
                        
                        UnderScoreSecureField(placeholder: "비밀번호", text: $viewModel.newPassword)
                    }
                    
                    HStack {
                        UnderScoreTextField(placeholder: "댓글을 입력해주세요.", text: $viewModel.newComment)
                        
                        Image(systemName: "paperplane.fill")
                            .onTapGesture {
                                viewModel.createComment()
                            }
                    }
                    
                }.padding()
                    .padding(.bottom, safeAreaInsets.bottom)
                    .background(Rectangle().foregroundColor(.white).shadow(radius: 5))
            }
        }.ignoresSafeArea(.all, edges: .bottom)
            .textFieldAlert(isPresented: $isModifyAlert) { () -> TextFieldAlert in
                TextFieldAlert(title: "댓글 수정", textFieldType: .double, action: viewModel.modifyComment, password: self.$viewModel.prevPassword, modifyString: self.$viewModel.modifiedComment)
            }
            .textFieldAlert(isPresented: $isDeleteAlert) { () -> TextFieldAlert in
                TextFieldAlert(title: "댓글 삭제", textFieldType: .delete, action: viewModel.deleteComment, password: self.$viewModel.prevPassword, modifyString: self.$viewModel.modifiedComment)
            }
            .toast(message: viewModel.errorMessage,
                   isShowing: $viewModel.showErrorToast)
            .navigationTitle("댓글")
            .introspectTabBarController { (UITabBarController) in
                UITabBarController.tabBar.isHidden = true
            }
            .onAppear {
                viewModel.onAppear(id: self.postId)
            }
    }
}

struct CommentRow: View {
    let comment: Comment
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(comment.nickname)
                
                Text(comment.content)
                    .font(.footnote)
            }
            
            Spacer()
        }.padding(.vertical, 10)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(postId: "627b3ccacafd0109cb908f77")
    }
}
