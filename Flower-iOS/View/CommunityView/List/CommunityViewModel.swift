//
//  CommunityViewModel.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/18.
//

import Foundation
import Combine

public final class CommunityViewModel: ObservableObject {
    @Published var search = ""
    @Published var posts = [Post]()
    
    private var bag = Set<AnyCancellable>()
    private let repository: CommunityRepository
    
    public init(repository: CommunityRepository = CommunityRepositoryImpl()) {
        self.repository = repository
        
        search.publisher
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.repository.getCommunity(search: self.search, completion: {
                    self.posts = $0
                })
            })
            .store(in: &bag)
    }
    
    public func onAppear() {
        repository.getCommunity(search: "", completion: {
            self.posts = $0
        })
    }
}
