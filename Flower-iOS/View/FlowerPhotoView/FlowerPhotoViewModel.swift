//
//  FlowerPhotoViewModel.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/16.
//

import Foundation
import Combine
import UIKit

class FlowerPhotoViewModel: ObservableObject {
    @Published var search = ""
    @Published var flowers = [Flower]()
    @Published var selectedImage: UIImage?
    
    public var isEmptyResult: Bool {
        return self.search.isEmpty && self.flowers.isEmpty
    }
    
    private var bag = Set<AnyCancellable>()
    private let openAPIRepository: OpenAPIRepository
    private let imageSearchRepository: ImageSearchRepository
    
    init(openAPIRepository: OpenAPIRepository = OpenAPIRepositoryImpl(),
         imageSearchRepository: ImageSearchRepository = ImageSearchRepositoryImpl()) {
        self.openAPIRepository = openAPIRepository
        self.imageSearchRepository = imageSearchRepository
        
        self.$search
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] word in
                guard let self = self else { return }
                
                if word == "" {
                    self.flowers = []
                } else {
                    self.openAPIRepository.getFlowerList(type: .name, word: word) {
                        self.flowers = $0
                    }
                }
            }.store(in: &bag)
        
        self.$selectedImage
            .removeDuplicates()
            .sink(receiveValue: { [weak self] image in
                guard let self = self else { return }
                guard let image = image else { return }
                
                let imageData = image.jpegData(compressionQuality: 1.0)!
                self.imageSearchRepository.getFlower(image: imageData, completion: {
                    self.flowers = $0
                })
            }).store(in: &bag)
    }
}
