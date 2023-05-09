//
//  VarBlock.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/10.
//

import SwiftUI

struct VarBlock: BlockView {
    @State private var showInfo: Bool = false
    @State private var showDetail: Bool = true
    @State private var tempAddText: String = ""

    @Binding var status: Status
    @Binding var text: [String]

    var body: some View {
        Group {
            switch status {
            case .editor:
                editorView
            case .canvas:
                EmptyView()
            case .canvasEditing:
                canvasEditingView
            }
        }
    }

    @ViewBuilder
    private var editorView: some View {
        HStack(spacing: 12) {
            variableIcon
            Text("Variable")
                .font(.body)
                .fontWeight(.bold)
            Spacer()
            infoButton
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            AppColors.bg1.cornerRadius(15)
        )
    }

    @ViewBuilder
    private var canvasEditingView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                variableIcon
                Text("Variable")
                    .font(.body)
                    .fontWeight(.bold)
                Spacer()
                detailButton
            }
            if showDetail {
                detailContentView
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            AppColors.bg2.cornerRadius(15)
                .shadow(color: .black.opacity(0.1), radius: 10)
        )
    }

    private var variableIcon: some View {
        Image(systemName: "tray.full.fill")
            .font(.title3)
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background(Color.orange.cornerRadius(10))
    }

    private var infoButton: some View {
        Button {
            self.showInfo.toggle()
        } label: {
            Image(systemName: "info.circle")
                .font(.title3)
                .foregroundColor(.blue)
        }
        .popover(isPresented: $showInfo) {
            infoPopoverView
        }
    }

    private var detailButton: some View {
        Button {
            self.showDetail.toggle()
        } label: {
            Image(systemName: "ellipsis.circle")
                .font(.title3)
                .foregroundColor(.blue)
        }
    }

    private var infoPopoverView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                variableIcon

                Text("Variable")
                    .font(.body)
                    .fontWeight(.bold)

                Spacer()

                closeButton
            }
            .padding(.bottom, 20)

            Text("Variables can store a variety of data.")
                .foregroundColor(AppColors.text0)
                .multilineTextAlignment(.leading)
        }
        .padding(.all, 16)
    }

    private var closeButton: some View {
        Button {
            self.showInfo.toggle()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .font(.title3)
                .foregroundColor(AppColors.text2)
        }
    }

    private var detailContentView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Divider()
                .foregroundColor(.gray)
            variableList
            addVariableField
        }.padding(.top, 20)
    }

    private var variableList: some View {
        ForEach(text.indices, id: \.self) { index in
            HStack {
                Text(text[index])
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.text0)

                Spacer()

                if text.count > 1 {
                    deleteButton(at: index)
                }
            }
            .padding(.horizontal, 12)
        }
    }

    private func deleteButton(at index: Int) -> some View {
        Button {
            text.remove(at: index)
        } label: {
            Image(systemName: "minus.circle.fill")
                .font(.body)
                .foregroundColor(.red)
        }
    }

    private var addVariableField: some View {
        HStack(spacing: 12) {
            TextField("Add variable", text: $tempAddText)
                .font(.body)
                .foregroundColor(AppColors.text0)

            Button {
                if !tempAddText.isEmpty {
                    text.append(tempAddText)
                    tempAddText = ""
                }
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(AppColors.bg1)
                .shadow(radius: 1)
        )
    }
}
