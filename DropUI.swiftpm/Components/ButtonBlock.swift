//
//  ButtonBlock.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/09.
//

import SwiftUI

struct ButtonBlock: BlockView {
    @State private var showInfo: Bool = false
    @State private var showEditPopup: Bool = false

    @Binding var status: Status

    let action: () -> Void
    let deleteAction: () -> Void

    @State private var icon: String = "hand.thumbsup.fill"
    @State private var text: String = "Create Compliment"
    @State private var backgroundColor: Color = Color.blue.opacity(0.1)
    @State private var textColor: Color = Color.blue
    @State private var iconColor: Color = Color.blue

    let symbolData: [String] = [
        "hand.thumbsup.fill",
        "star.fill",
        "heart.fill",
        "smiley.fill",
        "lightbulb.fill"
    ]

    var body: some View {
        Group {
            switch status {
            case .editor:
                EditorView(showInfo: $showInfo)
            case .canvas:
                CanvasView(action: action, icon: icon, text: text, iconColor: iconColor, textColor: textColor, backgroundColor: backgroundColor)
            case .canvasEditing:
                CanvasEditingView(showEditPopup: $showEditPopup, deleteAction: deleteAction, icon: $icon, text: $text, iconColor: $iconColor, textColor: $textColor, backgroundColor: $backgroundColor, symbolData: symbolData)
            }
        }
    }
}

private struct EditorView: View {
    @Binding var showInfo: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "plus.circle.fill")
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Color.blue.cornerRadius(10))

            Text("Button")
                .font(.body)
                .fontWeight(.bold)

            Spacer()

            // info button
            Button {
                self.showInfo.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .font(.title3)
                    .foregroundColor(.blue)
            }
            .popover(isPresented: $showInfo) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.blue.cornerRadius(10))

                        Text("Button")
                            .font(.body)
                            .fontWeight(.bold)

                        Spacer()

                        // close button
                        Button {
                            self.showInfo.toggle()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title3)
                                .foregroundColor(AppColors.text2)
                        }
                    }
                    .padding(.bottom, 20)

                    Text("Buttons can perform various actions.\n\nIn this app, I have implemented a feature to display random compliment phrases")
                        .foregroundColor(AppColors.text0)
                        .multilineTextAlignment(.leading)
                }
                .padding(.all, 16)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            AppColors.bg1.cornerRadius(15)
        )
    }
}

private struct CanvasView: View {
    let action: () -> Void
    let icon: String
    let text: String
    let iconColor: Color
    let textColor: Color
    let backgroundColor: Color

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(iconColor)

                Text(text)
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(minHeight: 56)
            .background(
                Rectangle()
                    .cornerRadius(10)
                    .foregroundColor(backgroundColor)
            )
        }
    }
}

private struct CanvasEditingView: View {
    @Binding var showEditPopup: Bool
    let deleteAction: () -> Void
    @Binding var icon: String
    @Binding var text: String
    @Binding var iconColor: Color
    @Binding var textColor: Color
    @Binding var backgroundColor: Color
    let symbolData: [String]

    var body: some View {
        Button {
            self.showEditPopup.toggle()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(iconColor)

                Text(text)
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                    .padding(.trailing, 16)

                Spacer()

                Image(systemName: "ellipsis.circle")
                    .font(.title3)
                    .foregroundColor(.blue)
                    .popover(isPresented: $showEditPopup) {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Image(systemName: icon)
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .frame(width: 40, height: 40)
                                    .background(Color.yellow.cornerRadius(10))

                                Text("Compliment Button")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(AppColors.text0)

                                Spacer(minLength: 24)

                                Button {
                                    self.showEditPopup.toggle()
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title3)
                                        .foregroundColor(AppColors.text2)
                                }
                            }
                            .padding(.bottom, 24)

                            Group {
                                Text("Action")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(AppColors.text0)
                                    .padding(.bottom, 8)
                                HStack {
                                    Spacer()

                                    Text("State = Variable.random()")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.blue)

                                    Spacer()
                                }
                                    .padding(.all, 16)
                                    .background(
                                        Color.blue.opacity(0.1).cornerRadius(10)
                                    )
                                    .padding(.bottom, 16)
                            }

                            Group {
                                Text("Icon")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(AppColors.text0)
                                    .padding(.bottom, 8)

                                HStack(spacing: 16) {
                                    ForEach(symbolData, id: \.self) { symbol in
                                        let isSelected: Bool = self.icon == symbol

                                        Button {
                                            self.icon = symbol
                                        } label: {
                                            Image(systemName: symbol)
                                                .font(.title3)
                                                .foregroundColor(isSelected ? .white : AppColors.text2)
                                                .frame(width: 40, height: 40)
                                                .background(
                                                    Rectangle().cornerRadius(10)
                                                        .foregroundColor(isSelected ? Color.blue : Color.clear)

                                                )
                                        }
                                    }
                                }
                                .padding(.bottom, 16)
                            }

                            Group {
                                Text("Text")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(AppColors.text0)
                                    .padding(.bottom, 8)

                                TextField("Enter button text.", text: $text)
                                    .foregroundColor(AppColors.text0)
                                    .padding(.all, 16)
                                    .background(
                                        Color.primary.opacity(0.1).cornerRadius(10)
                                    )
                                    .padding(.bottom, 16)
                            }

                            Group {
                                ColorPicker("Icon Color", selection: $iconColor)
                                    .foregroundColor(AppColors.text0)
                                    .padding(.bottom, 16)

                                ColorPicker("Text Color", selection: $textColor)
                                    .foregroundColor(AppColors.text0)
                                    .padding(.bottom, 16)

                                ColorPicker("Background Color", selection: $backgroundColor)
                                    .foregroundColor(AppColors.text0)
                                    .padding(.bottom, 16)
                            }

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
                        .padding(.all, 16)
                    }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(minHeight: 56)
            .background(
                Rectangle()
                    .cornerRadius(10)
                    .foregroundColor(backgroundColor)
            )
        }
    }
}
