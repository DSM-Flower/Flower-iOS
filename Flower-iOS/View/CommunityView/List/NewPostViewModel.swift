//
//  NewPostViewModel.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/23.
//

import SwiftUI
import Combine

class NewPostViewModel: ObservableObject {
    @Published var nickname = ""
    @Published var password = ""
    @Published var title = ""
    @Published var content = ""
    @Published var selectedImage: UIImage?
    
    @Published var showErrorToast = false
    @Published var errorMessage = ""
    
    private var viewCloseAction: () -> () = {}
    
    private let repository: CommunityRepository
    
    private let errorSubject = PassthroughSubject<PostError, Never>()
    private var bag = Set<AnyCancellable>()
    
    public init(repository: CommunityRepository = CommunityRepositoryImpl()) {
        self.repository = repository
    }
    
    public func onAppear(viewCloseAction: @escaping () -> ()) {
        self.viewCloseAction = viewCloseAction
    }
    
    public func createPost() {
        var images = [Data]()
        
        if let selectedImage = selectedImage, let data = selectedImage.jpegData(compressionQuality: 1.0) {
            images.append(data)
        }
        
        self.repository.createPost(title: self.title, content: self.content, images: images, nickname: self.nickname, password: self.password, completion: {
            switch $0 {
            case .success:
                self.viewCloseAction()
            case let .failure(error: error):
                break
            }
        })
    }
}
