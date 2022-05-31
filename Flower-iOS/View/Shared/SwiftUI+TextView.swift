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
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if !text.isEmpty {
            uiView.text = text
            uiView.textColor = .black
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, $text, placeholder: placeholder)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        var text: Binding<String>
        let placeholder: String
        
        init(_ uiTextView: TextView, _ text: Binding<String>, placeholder: String) {
            self.parent = uiTextView
            self.text = text
            self.placeholder = placeholder
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
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
