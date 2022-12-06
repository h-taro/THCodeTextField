//
//  BaseUITextField.swift
//  
//
//  Created by 平石　太郎 on 2022/12/06.
//

import Combine
import UIKit

class BaseUITextField: UITextField {
    var deleteBackwardSubject: PassthroughSubject<Void, Never>?
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    override func deleteBackward() {
        if let deleteBackwardSubject = deleteBackwardSubject, let text = text, text.isEmpty {
            deleteBackwardSubject.send()
        }
        
        super.deleteBackward()
    }
}
