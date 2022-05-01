//
//  SwiftUI+TextView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/04/27.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.delegate = context.coordinator
        textView.layer.cornerRadius = 10
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.text = self.placeholder
        textView.textColor = UIColor.lightGray
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text, placeholder: placeholder)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        let placeholder: String
        
        init(_ text: Binding<String>, placeholder: String) {
            self.text = text
            self.placeholder = placeholder
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = self.placeholder
                textView.textColor = UIColor.lightGray
            }
        }
    }
}
