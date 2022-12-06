//
//  HomeViewModel.swift
//  Demo
//
//  Created by 平石　太郎 on 2022/12/06.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var firstValue: String = ""
    @Published var secondValue: String = ""
    @Published var thirdValue: String = ""
    @Published var fourthValue: String = ""
    @Published var fifthValue: String = ""
    @Published var sixthValue: String = ""
    
    @Published var focusTag: Int? = nil
    
    private(set) var tapTextFieldSubject: PassthroughSubject<Int, Never> = .init()
    private(set) var shouldChangeCharacterSubject: PassthroughSubject<Void, Never> = .init()
    private(set) var deleteBackwardSubject: PassthroughSubject<Void, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        subscribeTapTextField()
        subscribeShouldChangeCharacter()
        subscribeDeleteBackward()
    }

    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

// MARK: - SUBSCRIBE
extension HomeViewModel {
    private func subscribeTapTextField() {
        tapTextFieldSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tag in
                guard let self = self else { return }
                self.focusTag = tag
            }
            .store(in: &cancellables)
    }
    
    private func subscribeShouldChangeCharacter() {
        shouldChangeCharacterSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.focusTag == .zero {
                    self.focusTag = 1
                } else if self.focusTag == 1 {
                    self.focusTag = 2
                } else if self.focusTag == 2 {
                    self.focusTag = 3
                } else if self.focusTag == 3 {
                    self.focusTag = 4
                } else if self.focusTag == 4 {
                    self.focusTag = 5
                }
            }
            .store(in: &cancellables)
    }
    
    private func subscribeDeleteBackward() {
        deleteBackwardSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.focusTag == 5 {
                    self.focusTag = 4
                } else if self.focusTag == 4 {
                    self.focusTag = 3
                } else if self.focusTag == 3 {
                    self.focusTag = 2
                } else if self.focusTag == 2 {
                    self.focusTag = 1
                } else if self.focusTag == 1 {
                    self.focusTag = .zero
                }
            }
            .store(in: &cancellables)
    }
}
