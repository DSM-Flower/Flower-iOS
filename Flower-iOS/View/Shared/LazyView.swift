//
//  LazyView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/18.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    init(@ViewBuilder _ build: @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build() // << everything is created here
    }
}

