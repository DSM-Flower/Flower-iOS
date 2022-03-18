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
    
    private var bag = Set<AnyCancellable>()
//    private let repository: OpenAPIRepository
    
//    public init(repository: OpenAPIRepository = OpenAPIRepository()) {
//        self.repository = repository
//    }
}
