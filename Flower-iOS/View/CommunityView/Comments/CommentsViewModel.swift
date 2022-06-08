//
//  CommentsViewModel.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/18.
//

import Foundation
import Combine

class CommentsViewModel: ObservableObject {
    @Published var comments = [Comment]()
    
    @Published var newNickname = ""
    @Published var newPassword = ""
    @Published var newComment = ""
    
    @Published var prevPassword: String? = ""
    @Published var modifiedComment: String? = ""
    var selectedComment = Comment.EMPTY
    
    @Published var showErrorToast = false
    @Published var errorMessage = ""
    
    private var postId = ""
    
    private let communityRepository: CommunityRepository
    private let commentRepository: CommentRepository
    
    private let errorSubject = PassthroughSubject<CommentsError, Never>()
    private var bag = Set<AnyCancellable>()
    
    public init(communityRepository: CommunityRepository = CommunityRepositoryImpl(), commentRepository: CommentRepository = CommentRepositoryImpl()) {
        self.communityRepository = communityRepository
        self.commentRepository = commentRepository
        
        errorSubject.sink(receiveValue: { error in
            self.showErrorToast = true
            
            switch error {
            case .noContent:
                self.errorMessage = "내용을 작성해주세요."
            case .notMatchedPassword:
                self.errorMessage = "비밀번호가 일치하지 않습니다."
            case .serverError:
                self.errorMessage = "서버에 오류가 생겼습니다. 다시 시도해주세요."
            }
        }).store(in: &bag)
    }
    
    public func onAppear(id: String) {
        self.postId = id
        
        self.getComments()
    }
    
    private func getComments() {
        self.communityRepository.getDetailPost(id: self.postId, completion: {
            self.comments = $0.comments
        })
    }
    
    public func createComment() {
        if self.newComment == "" || self.newNickname == "" || self.newPassword == "" {
            self.errorSubject.send(.noContent)
        }
        
        self.commentRepository.createComment(postId: self.postId, content: self.newComment, nickname: self.newNickname, password: self.newPassword, completion: { result in
            switch result {
            case .success:
                self.newComment = ""
                self.newNickname = ""
                self.newPassword = ""
                
                self.getComments()
            case .failure:
                self.errorSubject.send(.serverError)
                break
            }
        })
    }
    
    public func modifyComment() {
        guard let prevPassword = prevPassword, let modifiedComment = modifiedComment else {
            return
        }
        
        self.commentRepository.modifyComment(id: self.selectedComment.id, content: modifiedComment, nickname: self.selectedComment.nickname, password: prevPassword, completion: {
            switch $0 {
            case .success:
                self.onAppear(id: self.postId)
            case let .failure(error: error):
                self.showErrorToast = true
                self.errorMessage = "비밀번호가 다릅니다."
            }
        })
    }
    
    public func deleteComment() {
        guard let prevPassword = prevPassword else {
            return
        }
        
        self.commentRepository.deleteComment(id: self.selectedComment.id, nickname: self.selectedComment.nickname, password: prevPassword, completion: {
            switch $0 {
            case .success:
                self.onAppear(id: self.postId)
            case let .failure(error: error):
                self.showErrorToast = true
                self.errorMessage = "비밀번호가 다릅니다."
            }
        })
    }
}
