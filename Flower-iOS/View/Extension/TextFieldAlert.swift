//
//  TextFieldAlert.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/04/27.
//

import UIKit
import SwiftUI
import Combine

enum TextFieldType {
    case single
    case double
    case delete
}

class TextFieldAlertViewController: UIViewController {
    // MARK: - Dependencies
    private let alertTitle: String
    private let message: String?
    @Binding private var password: String?
    @Binding private var modifyString: String?
    private let textFieldType: TextFieldType
    private let action: () -> ()
    private var isPresented: Binding<Bool>?
    
    // MARK: - Private Properties
    private var passwordSubscription: AnyCancellable?
    private var stringSubscription: AnyCancellable?
    
    init(title: String, message: String?, password: Binding<String?>, modifyString: Binding<String?>, textFieldType: TextFieldType, action: @escaping () -> (), isPresented: Binding<Bool>?) {
        self.alertTitle = title
        self.message = message
        self._password = password
        self._modifyString = modifyString
        self.textFieldType = textFieldType
        self.action = action
        self.isPresented = isPresented
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentAlertController()
    }
    
    private func presentAlertController() {
        guard passwordSubscription == nil && stringSubscription == nil else { return } // present only once
        
        let vc = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        vc.addTextField { [weak self] textField in
            guard let self = self else { return }
            textField.placeholder = "비밀번호"
            textField.isSecureTextEntry = true
            self.passwordSubscription = NotificationCenter.default
                .publisher(for: UITextField.textDidChangeNotification, object: textField)
                .map { ($0.object as? UITextField)?.text }
                .assign(to: \.password, on: self)
        }
        
        if textFieldType == .single {
            let action = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                self?.action()
                self?.isPresented?.wrappedValue = false
            }
            vc.addAction(action)
        } else if textFieldType == .delete {
            let action = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
                self?.action()
                self?.isPresented?.wrappedValue = false
            }
            vc.addAction(action)
        } else if textFieldType == .double {
            vc.addTextField { [weak self] textField in
                guard let self = self else { return }
                if let placeholder = self.modifyString {
                    textField.placeholder = placeholder
                }
                
                self.stringSubscription = NotificationCenter.default
                    .publisher(for: UITextField.textDidChangeNotification, object: textField)
                    .map { ($0.object as? UITextField)?.text }
                    .assign(to: \.modifyString, on: self)
            }
            
            let action = UIAlertAction(title: "수정", style: .default) { [weak self] _ in
                self?.action()
                self?.isPresented?.wrappedValue = false
            }
            vc.addAction(action)
        }
        
        let action = UIAlertAction(title: "취소", style: .cancel) { [weak self] _ in
            self?.isPresented?.wrappedValue = false
        }
        vc.addAction(action)
        
        present(vc, animated: true, completion: nil)
    }
}

struct TextFieldAlert {
    let title: String
    let textFieldType: TextFieldType
    let action: () -> ()
    @Binding var password: String?
    @Binding var modifyString: String?
    var isPresented: Binding<Bool>? = nil
    
    // MARK: Modifiers
    func dismissable(_ isPresented: Binding<Bool>) -> TextFieldAlert {
        TextFieldAlert(title: title, textFieldType: textFieldType, action: action, password: $password, modifyString: $modifyString, isPresented: isPresented)
    }
}

extension TextFieldAlert: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = TextFieldAlertViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<TextFieldAlert>) -> UIViewControllerType {
        TextFieldAlertViewController(title: title, message: nil, password: $password, modifyString: $modifyString, textFieldType: textFieldType, action: action, isPresented: isPresented)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType,
                                context: UIViewControllerRepresentableContext<TextFieldAlert>) {
        // no update needed
    }
}

struct TextFieldWrapper<PresentingView: View>: View {
    @Binding var isPresented: Bool
    let presentingView: PresentingView
    let content: () -> TextFieldAlert
    
    var body: some View {
        ZStack {
            if (isPresented) { content().dismissable($isPresented) }
            presentingView
        }
    }
}

extension View {
    func textFieldAlert(isPresented: Binding<Bool>,
                        content: @escaping () -> TextFieldAlert) -> some View {
        TextFieldWrapper(isPresented: isPresented,
                         presentingView: self,
                         content: content)
    }
}

