//
//  HomeView.swift
//  Demo
//
//  Created by 平石　太郎 on 2022/12/06.
//

import THCodeTextField
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = .init()
    
    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            Color.gray.opacity(0.2)
            
            ScrollView(.vertical, showsIndicators: false) {
                HStack(alignment: .center, spacing: 8) {
                    THCodeTextField(
                        text: $viewModel.firstValue,
                        focusTag: $viewModel.focusTag,
                        tag: .zero,
                        tapTextFieldSubject: viewModel.tapTextFieldSubject,
                        shouldChangeCharacterSubject: viewModel.shouldChangeCharacterSubject,
                        deleteBackwardSubject: viewModel.deleteBackwardSubject
                    )
                    
                    THCodeTextField(
                        text: $viewModel.secondValue,
                        focusTag: $viewModel.focusTag,
                        tag: 1,
                        tapTextFieldSubject: viewModel.tapTextFieldSubject,
                        shouldChangeCharacterSubject: viewModel.shouldChangeCharacterSubject,
                        deleteBackwardSubject: viewModel.deleteBackwardSubject
                    )
                    THCodeTextField(
                        text: $viewModel.thirdValue,
                        focusTag: $viewModel.focusTag,
                        tag: 2,
                        tapTextFieldSubject: viewModel.tapTextFieldSubject,
                        shouldChangeCharacterSubject: viewModel.shouldChangeCharacterSubject,
                        deleteBackwardSubject: viewModel.deleteBackwardSubject
                    )
                    THCodeTextField(
                        text: $viewModel.fourthValue,
                        focusTag: $viewModel.focusTag,
                        tag: 3,
                        tapTextFieldSubject: viewModel.tapTextFieldSubject,
                        shouldChangeCharacterSubject: viewModel.shouldChangeCharacterSubject,
                        deleteBackwardSubject: viewModel.deleteBackwardSubject
                    )
                    THCodeTextField(
                        text: $viewModel.fifthValue,
                        focusTag: $viewModel.focusTag,
                        tag: 4,
                        tapTextFieldSubject: viewModel.tapTextFieldSubject,
                        shouldChangeCharacterSubject: viewModel.shouldChangeCharacterSubject,
                        deleteBackwardSubject: viewModel.deleteBackwardSubject
                    )
                    THCodeTextField(
                        text: $viewModel.sixthValue,
                        focusTag: $viewModel.focusTag,
                        tag: 5,
                        tapTextFieldSubject: viewModel.tapTextFieldSubject,
                        shouldChangeCharacterSubject: viewModel.shouldChangeCharacterSubject,
                        deleteBackwardSubject: viewModel.deleteBackwardSubject
                    )
                }
                .padding(.horizontal)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
