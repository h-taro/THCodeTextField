import Combine
import SwiftUI

public struct THCodeTextField: View {
    @StateObject private var viewModel: THCodeTextFieldViewModel = .init()
    
    private var text: Binding<String>
    private var focusTag: Binding<Int?>
    private let tag: Int
    private let tapTextFieldSubject: PassthroughSubject<Int, Never>
    private let shouldChangeCharacterSubject: PassthroughSubject<Void, Never>
    private let deleteBackwardSubject: PassthroughSubject<Void, Never>
    
    public init(
        text: Binding<String>,
        focusTag: Binding<Int?>,
        tag: Int,
        tapTextFieldSubject: PassthroughSubject<Int, Never>,
        shouldChangeCharacterSubject: PassthroughSubject<Void, Never>,
        deleteBackwardSubject: PassthroughSubject<Void, Never>
    ) {
        self.text = text
        self.focusTag = focusTag
        self.tag = tag
        self.tapTextFieldSubject = tapTextFieldSubject
        self.shouldChangeCharacterSubject = shouldChangeCharacterSubject
        self.deleteBackwardSubject = deleteBackwardSubject
    }
    
    public var body: some View {
        UITextFieldRepresentable(
            text: text,
            focusTag: focusTag,
            tag: tag,
            tapTextFieldSubject: tapTextFieldSubject,
            shouldChangeCharacterSubject: shouldChangeCharacterSubject,
            deleteBackwardSubject: deleteBackwardSubject,
            didBeginEditingSubject: viewModel.didBeginEditingSubject,
            didEndEditingSubject: viewModel.didEndEditingSubject
        )
        .background(textFieldBackground)
    }
    
    private var textFieldBackground: some View {
        Group {
            if viewModel.isFocused {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue.opacity(0.1), lineWidth: 2)
                    )
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.4))
            }
        }
    }
}
