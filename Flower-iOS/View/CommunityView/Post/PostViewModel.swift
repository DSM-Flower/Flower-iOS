//
//  PostViewModel.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/18.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var post = DetailPost.EMPTY
    
    @Published var prevPassword: String? = ""
    @Published var deletePostTitle: String? = ""
    @Published var modifiedContent = ""
    
    @Published var showErrorToast = false
    @Published var errorMessage = ""
    
    private let repository: CommunityRepository
    private var viewCloseAction: () -> () = {}
    
    public init(repository: CommunityRepository = CommunityRepositoryImpl()) {
        self.repository = repository
    }
    
    public func onAppear(id: String, viewCloseAction: @escaping () -> ()) {
        self.viewCloseAction = viewCloseAction
        
        self.repository.getDetailPost(id: id, completion: {
            self.post = $0
            self.modifiedContent = $0.content
            self.deletePostTitle = $0.title
        })
    }
    
    public func modifyPost() {
        guard let prevPassword = prevPassword else {
            return
        }
        
        var imageDatas = [Data]()
        
        for image in post.image {
            repository.getImageData(id: image, completion: {
                if $0 != nil {
                    imageDatas.append($0!)
                }
            })
        }
        
        self.repository.modifyPost(id: self.post.id, title: self.post.title, content: self.modifiedContent, images: imageDatas, nickname: self.post.nickname, password: prevPassword, completion: {
            switch $0 {
            case .success:
                self.onAppear(id: self.post.id, viewCloseAction: self.viewCloseAction)
            case let .failure(error: error):
                self.showErrorToast = true
                self.errorMessage = "비밀번호가 다릅니다."
            }
        })
    }
    
    public func deletePost() {
        guard let prevPassword = prevPassword else {
            return
        }

        self.repository.deletePost(id: self.post.id, nickname: self.post.nickname, password: prevPassword, completion: {
            switch $0 {
            case .success:
                self.viewCloseAction()
            case let .failure(error: error):
                self.showErrorToast = true
                self.errorMessage = "비밀번호가 다릅니다."
            }
        })
    }
}
