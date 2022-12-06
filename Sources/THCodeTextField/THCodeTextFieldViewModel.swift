//
//  File.swift
//
//
//  Created by 平石　太郎 on 2022/12/06.
//

import Combine

class THCodeTextFieldViewModel: ObservableObject {
    @Published private(set) var isFocused = false
    private(set) var didBeginEditingSubject: PassthroughSubject<Void, Never> = .init()
    private(set) var didEndEditingSubject: PassthroughSubject<Void, Never> = .init()
}
