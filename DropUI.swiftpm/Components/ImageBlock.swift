//
//  ImageBlock.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/10.
//

import SwiftUI

struct ImageBlock: BlockView {
    @State private var showInfo: Bool = false
    @State private var showEditor: Bool = false
    @State private var showPhotoPicker: Bool = false

    @State private var image: UIImage?

    @Binding var status: Status

    var body: some View {
        switch status {
        case .editor:
            editorView
        case .canvasEditing:
            canvasEditingView
        case .canvas:
            canvasView
        }
    }

    private var editorView: some View {
        HStack(spacing: 12) {
            Image(systemName: "photo.on.rectangle.angled")
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Color.purple.cornerRadius(10))

            Text("Image")
                .font(.body)
                .fontWeight(.bold)

            Spacer()

            // Info button
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
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            AppColors.bg1.cornerRadius(15)
        )
    }

    private var canvasEditingView: some View {
        Button {
            self.showPhotoPicker.toggle()
        } label: {
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.purple.cornerRadius(10))

                    Text("Image")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(AppColors.text0)

                    Spacer()

                    Text("Select")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }

                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 12)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                AppColors.bg2.cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 10)
            )
        }
        .sheet(isPresented: $showPhotoPicker) {
            ImagePicker(image: $image)
        }
    }

    private var canvasView: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.purple.cornerRadius(10))
            }
        }
    }

    private var infoPopoverView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.purple.cornerRadius(10))

                Text("Image")
                    .font(.body)
                    .fontWeight(.bold)

                Spacer()

                // Close button
                Button {
                    self.showInfo.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(AppColors.text2)
                }
            }
            .padding(.bottom, 20)

            Text("Displays the desired image.")
                .foregroundColor(AppColors.text0)
                .multilineTextAlignment(.leading)
        }
        .padding(.all, 16)
    }
}
