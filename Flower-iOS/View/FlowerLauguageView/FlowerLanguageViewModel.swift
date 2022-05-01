//
//  FlowerLanguageViewModel.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/16.
//

import Foundation
import Combine

class FlowerLanguageViewModel: ObservableObject {
    @Published var search = ""
    @Published var flowers = [Flower]()
    
    private var bag = Set<AnyCancellable>()
    private let repository: OpenAPIRepository
    
    init(repository: OpenAPIRepository = OpenAPIRepositoryImpl()) {
        self.repository = repository
        
        self.$search
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] word in
                guard let self = self else { return }
                
                if word == "" {
                    self.flowers = []
                } else {
                    self.repository.getFlowerList(type: .flowerLanguage, word: word) {
                        self.flowers = $0
                    }
                }
            }.store(in: &bag)
    }
}
