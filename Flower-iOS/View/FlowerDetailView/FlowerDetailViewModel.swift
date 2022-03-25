//
//  FlowerDetailViewModel.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/18.
//

import Foundation
import Combine

public final class FlowerDetailViewModel: ObservableObject {
    @Published var flower = Flower.Empty
    
    private var bag = Set<AnyCancellable>()
    private let repository: OpenAPIRepository
    
    public init(repository: OpenAPIRepository = OpenAPIRepository()) {
        self.repository = repository
    }
    
    public func onAppear(no: Int) {
        self.repository.getFlower(dataNo: no, completion: {
            self.flower = $0
        })
    }
}
