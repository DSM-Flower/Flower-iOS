//
//  UnderScoreTextField.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/04/27.
//

import SwiftUI

struct UnderScoreTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 3) {
            TextField(placeholder, text: $text)
            
            CustomDivider()
        }
    }
}
