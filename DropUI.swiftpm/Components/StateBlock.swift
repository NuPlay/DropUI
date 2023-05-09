//
//  StateBlock.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/10.
//

import SwiftUI

struct StateBlock: BlockView {
    @State private var showInfo: Bool = false

    @Binding var status: Status

    var body: some View {
        Group {
            switch status {
            case .editor:
                editorView
            case .canvasEditing:
                canvasEditingView
            case .canvas:
                EmptyView()
            }
        }
    }

    @ViewBuilder
    private var editorView: some View {
        HStack(spacing: 12) {
            stateIcon
            Text("State")
                .font(.body)
                .fontWeight(.bold)
            Spacer()
            infoButton
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(AppColors.bg1.cornerRadius(15))
    }

    @ViewBuilder
    private var canvasEditingView: some View {
        HStack(spacing: 12) {
            stateIcon
            Text("State")
                .font(.body)
                .fontWeight(.bold)

            Text("Link State with Text block")
                .foregroundColor(AppColors.text1)

            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(AppColors.bg2.cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 10)
        )
    }

    private var stateIcon: some View {
        Image(systemName: "arrow.triangle.2.circlepath")
            .font(.title3)
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background(Color.green.cornerRadius(10))
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
            VStack(alignment: .leading, spacing: 0) {
                infoHeader
                Text("Changing the state data will be reflected in the view.")
                    .foregroundColor(AppColors.text0)
                    .multilineTextAlignment(.leading)
            }
            .padding(.all, 16)
        }
    }

    private var infoHeader: some View {
        HStack {
            stateIcon
            Text("State")
                .font(.body)
                .fontWeight(.bold)
            Spacer()
            closeButton
        }
        .padding(.bottom, 20)
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
}

struct StateBlock_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AppColors.bg0.ignoresSafeArea()

            StateBlock(status: .constant(.canvasEditing))
        }
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
