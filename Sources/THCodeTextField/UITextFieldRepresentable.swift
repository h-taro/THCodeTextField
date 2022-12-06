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
    
    private let doneStringKey: String
    private let tableName: String
    private let tag: Int
    
    private let tapTextFieldSubject: PassthroughSubject<Void, Never>
    private let didBeginEditingSubject: PassthroughSubject<Void, Never>
    private let didEndEditingSubject: PassthroughSubject<Void, Never>
    private let editingChangedSubject: PassthroughSubject<Void, Never>
    private let deleteBackwardSubject: PassthroughSubject<Void, Never>
    
    init(
        text: Binding<String>,
        focusTag: Binding<Int?>,
        doneStringKey: String,
        tableName: String,
        tag: Int,
        tapTextFieldSubject: PassthroughSubject<Void, Never>,
        didBeginEditingSubject: PassthroughSubject<Void, Never>,
        didEndEditingSubject: PassthroughSubject<Void, Never>,
        editingChangedSubject: PassthroughSubject<Void, Never>,
        deleteBackwardSubject: PassthroughSubject<Void, Never>
    ) {
        self._text = text
        self._focusTag = focusTag
        self.doneStringKey = doneStringKey
        self.tableName = tableName
        self.tag = tag
        self.tapTextFieldSubject = tapTextFieldSubject
        self.didBeginEditingSubject = didBeginEditingSubject
        self.didEndEditingSubject = didEndEditingSubject
        self.editingChangedSubject = editingChangedSubject
        self.deleteBackwardSubject = deleteBackwardSubject
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
            title: NSLocalizedString(doneStringKey, tableName: tableName, comment: ""),
            style: .done,
            target: context.coordinator,
            action: #selector(context.coordinator.onTapDoneButton)
        )
        toolBar.setItems([spacer, doneButton], animated: true)
        
        textField.inputAccessoryView = toolBar
        
        return textField
    }
    
    func updateUIView(_ uiView: BaseUITextField, context: Context) {
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
    }
}
