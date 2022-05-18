//
//  UnderScoreSecureField.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/05/18.
//

import SwiftUI

struct UnderScoreSecureField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 3) {
            SecureField(placeholder, text: $text)
            
            CustomDivider()
        }
    }
}
