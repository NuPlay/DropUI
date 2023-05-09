//
//  DragAndDropView.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/09.
//

import SwiftUI

struct DragAndDropView: View {
    @StateObject var viewModel = ViewModel()

    @State private var dropView: [Block] = []

    let canvasEnd: () -> Void

    var body: some View {
        HStack {
            ComponentsList(viewModel: viewModel)

            Spacer(minLength: 32)

            CanvasSection(viewModel: viewModel, canvasEnd: canvasEnd)
        }
        .padding(.all, 24)
        .background(AppColors.bg0.ignoresSafeArea())
        .animation(.spring())
    }
}

struct ComponentsList: View {
    @ObservedObject var viewModel: DragAndDropView.ViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("DropUI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 24)

                ComponentsHeader(viewModel: viewModel)

                ComponentsArea(viewModel: viewModel)

                TaskDescription()

                Spacer()
            }
        }
        .frame(maxWidth: 300)
    }
}

struct ComponentsHeader: View {
    @ObservedObject var viewModel: DragAndDropView.ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Components")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 6)

            Text("Drag & Drop components to use.")
                .font(.body)
                .foregroundColor(AppColors.text1)
                .padding(.bottom, 8)
        }
        .padding(.leading, 6)
    }
}

struct ComponentsArea: View {
    @ObservedObject var viewModel: DragAndDropView.ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ButtonBlock(status: .constant(.editor)) {

            } deleteAction: {

            }
            .draggable(Block.button.toString())

            ImageBlock(status: .constant(.editor))
                .draggable(Block.image.toString())

            TextBlock(text: $viewModel.complementText, status: .constant(.editor)) {

            }
            .draggable(Block.text.toString())

            VarBlock(status: .constant(.editor), text: $viewModel.complements)
                .draggable(Block.variable.toString())

            StateBlock(status: .constant(.editor))
                .draggable(Block.state.toString())
        }
        .padding(.all, 16)
        .background(
            Color.primary.opacity(0.1).cornerRadius(16)
                .shadow(radius: 1)
        )
        .padding(.bottom, 32)
    }
}

struct TaskDescription: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Task Description")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 6)

            Text("Create an app by dragging and dropping all available components onto the canvas.\n\nEach component offers various options once placed on the canvas.\nClick on the components to access these options.\n\nMake sure to incorporate all provided components for a comprehensive and functional app.")
                .font(.body)
                .foregroundColor(AppColors.text0)
                .lineSpacing(10)
                .multilineTextAlignment(.leading)
                .padding(.all, 16)
                .background(
                    AppColors.bg1
                        .cornerRadius(10)
                )
        }
    }
}

struct CanvasSection: View {
    @ObservedObject var viewModel: DragAndDropView.ViewModel
    let canvasEnd: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            CanvasHeader(viewModel: viewModel, canvasEnd: canvasEnd)

            CanvasArea(viewModel: viewModel)
        }
    }
}

struct CanvasHeader: View {
    @ObservedObject var viewModel: DragAndDropView.ViewModel
    let canvasEnd: () -> Void

    var body: some View {
        HStack {
            Text("Canvas")
                .font(.largeTitle)
                .fontWeight(.bold)

            Spacer()

            if viewModel.canvasEditing {
                Button {
                    viewModel.removeAll()
                } label: {
                    HStack {
                        Image(systemName: "arrow.clockwise")

                        Text("Reset")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.red)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        Color.red.opacity(0.1).cornerRadius(10)
                    )
                }
            }
            CanvasModeButton(viewModel: viewModel)
            if viewModel.canvasEditing == false {
                Button {
                    canvasEnd()
                } label: {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")

                        Text("Complete")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        Color.blue.cornerRadius(10)
                    )
                }
            }
        }
    }
}

struct CanvasModeButton: View {
    @ObservedObject var viewModel: DragAndDropView.ViewModel

    var body: some View {
        Button {
            viewModel.canvasEditing.toggle()
        } label: {
            HStack {
                Image(systemName: "slider.horizontal.3")

                Text(viewModel.canvasEditing ? "Live Mode" : "Edit Mode")
                    .fontWeight(.bold)
            }
            .foregroundColor(viewModel.canvasEditing ? .white : .blue)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                Color.blue.opacity(viewModel.canvasEditing ? 1 : 0.1).cornerRadius(10)
            )

        }
    }
}

struct CanvasArea: View {
    @ObservedObject var viewModel: DragAndDropView.ViewModel

    var body: some View {
        ScrollView {
            HStack {
                Spacer()

                VStack {
                    ForEach(0 ..< viewModel.dropView.count, id: \.self) { index in
                        let data: Block = viewModel.dropView[index]

                        switch data {
                        case .button:
                            ButtonBlock(status: .constant(viewModel.canvasEditing ? .canvasEditing : .canvas)) {
                                viewModel.getRandomComplement()
                            } deleteAction: {
                                viewModel.removeBlock(index)
                            }
                        case .text:
                            TextBlock(text: $viewModel.complementText, status: .constant(viewModel.canvasEditing ? .canvasEditing : .canvas)) {
                                viewModel.removeBlock(index)
                            }
                        case .variable:
                            VarBlock(status: .constant(viewModel.canvasEditing ? .canvasEditing : .canvas), text: $viewModel.complements)
                        case .state:
                            StateBlock(status: .constant(viewModel.canvasEditing ? .canvasEditing : .canvas))
                        case .image:
                            ImageBlock(status: .constant(viewModel.canvasEditing ? .canvasEditing : .canvas))

                        default:
                            Text("error")
                        }
                    }
                }
                .padding(.all, 32)

                Spacer()
            }
        }
        .background(
            ZStack {
                AppColors.bg1
                    .cornerRadius(20)

                if viewModel.dropView.isEmpty {
                    Text("Drop components here.")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(AppColors.text2)
                }
            }
        )
        .dropDestination(for: String.self) { items, _ in
            viewModel.addBlock(items.first ?? "error")
            return true
        }
    }
}
