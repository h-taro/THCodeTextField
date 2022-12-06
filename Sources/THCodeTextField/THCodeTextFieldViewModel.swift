//
//  File.swift
//  
//
//  Created by 平石　太郎 on 2022/12/06.
//

import Foundation
import Combine

class THCodeTextFieldViewModel: ObservableObject {
    @Published private(set) var isFocused = false
    
    private(set) var didBeginEditingSubject: PassthroughSubject<Void, Never> = .init()
    private(set) var didEndEditingSubject: PassthroughSubject<Void, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        subscribeDidBeginEditing()
        subscribeDidEndEditing()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

// MARK: - SUBSCRIBE
extension THCodeTextFieldViewModel {
    private func subscribeDidBeginEditing() {
        didBeginEditingSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.isFocused = true
            }
            .store(in: &cancellables)
    }
    
    private func subscribeDidEndEditing() {
        didEndEditingSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.isFocused = false
            }
            .store(in: &cancellables)
    }
}
