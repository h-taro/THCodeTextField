//
//  File.swift
//  
//
//  Created by 平石　太郎 on 2022/12/06.
//

import Combine
import SwiftUI

struct UITextFieldRepresentable: UIViewRepresentable {
    @Binding private var text: String
    @Binding private var focusTag: Int?
    
    private let tag: Int
    
    private let tapTextFieldSubject: PassthroughSubject<Int, Never>
    private let didBeginEditingSubject: PassthroughSubject<Void, Never>
    private let didEndEditingSubject: PassthroughSubject<Void, Never>
    private let shouldChangeCharacterSubject: PassthroughSubject<Void, Never>
    private let deleteBackwardSubject: PassthroughSubject<Void, Never>
    
    init(
        text: Binding<String>,
        focusTag: Binding<Int?>,
        tag: Int,
        tapTextFieldSubject: PassthroughSubject<Int, Never>,
        shouldChangeCharacterSubject: PassthroughSubject<Void, Never>,
        deleteBackwardSubject: PassthroughSubject<Void, Never>,
        didBeginEditingSubject: PassthroughSubject<Void, Never>,
        didEndEditingSubject: PassthroughSubject<Void, Never>
    ) {
        self._text = text
        self._focusTag = focusTag
        self.tag = tag
        self.tapTextFieldSubject = tapTextFieldSubject
        self.shouldChangeCharacterSubject = shouldChangeCharacterSubject
        self.deleteBackwardSubject = deleteBackwardSubject
        self.didBeginEditingSubject = didBeginEditingSubject
        self.didEndEditingSubject = didEndEditingSubject
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> BaseUITextField {
        let textField = BaseUITextField()
        
        textField.delegate = context.coordinator
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .default
        textField.tag = tag
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.deleteBackwardSubject = deleteBackwardSubject
        textField.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.onEditingChanged(_:)),
            for: .editingChanged
        )
        
        let toolBar = UIToolbar(frame: .init(x: .zero, y: .zero, width: textField.frame.size.width, height: 44))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            title: "完了",
            style: .done,
            target: context.coordinator,
            action: #selector(context.coordinator.onTapDoneButton)
        )
        toolBar.setItems([spacer, doneButton], animated: true)
        
        textField.inputAccessoryView = toolBar
        
        return textField
    }
    
    func updateUIView(_ uiView: BaseUITextField, context: Context) {
        if uiView.tag == focusTag {
            uiView.becomeFirstResponder()
        }
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        private let parent: UITextFieldRepresentable
        
        init(_ parent: UITextFieldRepresentable) {
            self.parent = parent
        }
        
        @objc func onEditingChanged(_ textField: UITextField) {
            guard let text = textField.text else { return }
            parent.text = text
        }
        
        @objc func onTapDoneButton() {
            UIApplication.shared.endEditing()
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.tapTextFieldSubject.send(textField.tag)
            parent.didBeginEditingSubject.send()
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.didEndEditingSubject.send()
        }
        
        func textField(
            _ textField: UITextField,
            shouldChangeCharactersIn range: NSRange,
            replacementString string: String
        ) -> Bool {
            guard let text = textField.text else { return false }
            
            if text.count < 1 {
                parent.shouldChangeCharacterSubject.send()
                return true
            } else {
                if string.isBackspace() {
                    return true
                } else {
                    textField.selectAll(nil)
                    parent.shouldChangeCharacterSubject.send()
                    return true
                }
            }
        }
    }
}
