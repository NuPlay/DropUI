//
//  TextBlock.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/09.
//

import SwiftUI

struct TextBlock: BlockView {
    @State private var showInfo: Bool = false
    @State private var showControlPannel: Bool = false
    @State private var bindingText: Bool = true
    @State private var plainText: String = ""

    @Binding var text: String
    @Binding var status: Status

    let deleteAction: () -> Void

    @State private var fontSize: CGFloat = 24
    @State private var fontWeightIndex = 0

    @State private var textColor: Color = AppColors.text0

    let fontWeights: [(name: String, weight: Font.Weight)] = [
        ("Light", .light),
        ("Regular", .regular),
        ("Semibold", .semibold),
        ("Bold", .bold)
    ]

    var body: some View {
        Group {
            switch status {
            case .editor:
                blockEditorView(showInfo: $showInfo)

            case .canvas:
                Text(bindingText ? text : plainText)
                    .font(.system(size: fontSize))
                    .fontWeight(fontWeights[fontWeightIndex].weight)
                    .foregroundColor(textColor)

            case .canvasEditing:
                blockCanvasEditingView(showControlPannel: $showControlPannel,
                                       bindingText: $bindingText,
                                       plainText: $plainText,
                                       fontSize: $fontSize,
                                       fontWeightIndex: $fontWeightIndex,
                                       textColor: $textColor,
                                       fontWeights: fontWeights,
                                       text: text,
                                       deleteAction: deleteAction)
            }
        }
    }

    @ViewBuilder
    private func blockEditorView(showInfo: Binding<Bool>) -> some View {
        HStack {
            blockHeaderView(showInfo: showInfo)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            AppColors.bg1.cornerRadius(15)
        )
    }

    @ViewBuilder
    private func blockHeaderView(showInfo: Binding<Bool>) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "textformat")
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Color.yellow.cornerRadius(10))

            Text("Text")
                .font(.body)
                .fontWeight(.bold)

            Spacer()

            // info button
            Button {
                showInfo.wrappedValue.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .font(.title3)
                    .foregroundColor(.blue)
            }
            .popover(isPresented: showInfo) {
                blockInfoView(showInfo: showInfo)
            }
        }
    }

    @ViewBuilder
    private func blockInfoView(showInfo: Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "textformat")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.yellow.cornerRadius(10))

                Text("Text")
                    .font(.body)
                    .fontWeight(.bold)

                Spacer()

                // close button
                Button {
                    showInfo.wrappedValue.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(AppColors.text2)
                }
            }
            .padding(.bottom, 20)

            Text("Displays the specified text content")
                .foregroundColor(AppColors.text0)
                .multilineTextAlignment(.leading)
        }
        .padding(.all, 16)
        .frame(width: 250)
    }

    @ViewBuilder
    private func blockCanvasEditingView(showControlPannel: Binding<Bool>,
                                        bindingText: Binding<Bool>,
                                        plainText: Binding<String>,
                                        fontSize: Binding<CGFloat>,
                                        fontWeightIndex: Binding<Int>,
                                        textColor: Binding<Color>,
                                        fontWeights: [(name: String, weight: Font.Weight)],
                                        text: String,
                                        deleteAction: @escaping () -> Void) -> some View {
        Button {
            showControlPannel.wrappedValue.toggle()
        } label: {
            HStack {
                Image(systemName: "textformat")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.yellow.cornerRadius(10))

                if bindingText.wrappedValue {
                    Text(text)
                        .font(.system(size: fontSize.wrappedValue))
                        .fontWeight(fontWeights[fontWeightIndex.wrappedValue].weight)
                        .foregroundColor(textColor.wrappedValue)
                        .padding(.trailing, 16)
                } else {
                    if plainText.wrappedValue.isEmpty {
                        Text("Enter text")
                            .font(.system(size: fontSize.wrappedValue))
                            .fontWeight(fontWeights[fontWeightIndex.wrappedValue].weight)
                            .foregroundColor(AppColors.text1)
                            .padding(.trailing, 16)
                    } else {
                        Text(plainText.wrappedValue)
                            .font(.system(size: fontSize.wrappedValue))
                            .fontWeight(fontWeights[fontWeightIndex.wrappedValue].weight)
                            .foregroundColor(textColor.wrappedValue)
                            .padding(.trailing, 16)
                    }
                }

                Spacer()

                Image(systemName: "ellipsis.circle")
                    .font(.title3)
                    .foregroundColor(.blue)
                    .popover(isPresented: showControlPannel) {
                        blockControlPannelView(showControlPannel: showControlPannel,
                                               bindingText: bindingText,
                                               plainText: plainText,
                                               fontSize: fontSize,
                                               fontWeightIndex: fontWeightIndex,
                                               textColor: textColor,
                                               fontWeights: fontWeights,
                                               deleteAction: deleteAction)
                    }
            }
            .padding(.all, 10)
            .background(
                AppColors.bg2.cornerRadius(10)
                    .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 0)
            )
        }
    }

    @ViewBuilder
    private func blockControlPannelView(showControlPannel: Binding<Bool>,
                                        bindingText: Binding<Bool>,
                                        plainText: Binding<String>,
                                        fontSize: Binding<CGFloat>,
                                        fontWeightIndex: Binding<Int>,
                                        textColor: Binding<Color>,
                                        fontWeights: [(name: String, weight: Font.Weight)],
                                        deleteAction: @escaping () -> Void) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "textformat")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.yellow.cornerRadius(10))

                Text("Text")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.text0)

                Spacer(minLength: 24)

                Button {
                    showControlPannel.wrappedValue.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(AppColors.text2)
                }
            }
            .padding(.bottom, 16)

            Toggle(isOn: bindingText) {
                Text("State Binding")
                    .foregroundColor(AppColors.text0)
            }
            .padding(.bottom, 16)

            if bindingText.wrappedValue == false {
                TextField("Enter text", text: plainText)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(content: {
                        Color.primary.opacity(0.1)
                            .cornerRadius(10)
                    })
                    .padding(.bottom, 16)
            }

            VStack(alignment: .leading, spacing: 0) {
                Stepper("Font size: \(Int(fontSize.wrappedValue))", value: fontSize, in: 12...48, step: 1)
                    .foregroundColor(AppColors.text0)
                    .padding(.bottom, 16)

                Text("FontWeight")
                    .foregroundColor(AppColors.text0)
                    .padding(.bottom, 8)

                Picker("Choose a Side", selection: fontWeightIndex) {
                    ForEach(0..<fontWeights.count, id: \.self) { index in
                        Text(fontWeights[index].name).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 16)

                ColorPicker(selection: textColor) {
                    Text("Text color")
                        .foregroundColor(AppColors.text0)
                }
                .padding(.bottom, 16)

                Button {
                    deleteAction()
                } label: {
                    HStack {
                        Spacer()
                        Text("Delete")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)

                        Spacer()
                    }
                    .background(
                        Color.red.opacity(0.1)
                            .cornerRadius(10)
                    )
                }
            }
        }
        .padding(.all, 16)
        .animation(.spring())
    }
}
