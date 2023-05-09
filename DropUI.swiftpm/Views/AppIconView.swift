//
//  AppIconView.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/09.
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    @State private var drawing = PKDrawing()
    @State private var toolPickerIsActive: Bool = true

    let action: (UIImage?) -> Void

    var body: some View {
        VStack(spacing: 40) {
            Text("Draw your app icon")
                .font(.largeTitle)
                .fontWeight(.bold)

            IconDrawingView(drawing: $drawing, toolPickerIsActive: $toolPickerIsActive)
                .frame(width: 300, height: 300)
                .cornerRadius(20)
                .mask(RoundedRectangle(cornerRadius: 20))

            Button(action: {
                self.toolPickerIsActive = false
                action(drawing.image(from: CGRect(x: 0, y: 0, width: 300, height: 300), scale: UIScreen.main.scale))
            }) {
                Text("Done")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 72)
                    .padding(.vertical, 20)
                    .background(
                        Color.blue.opacity(0.1)
                            .cornerRadius(20)
                    )
            }
        }
        .padding(.all, 32)
    }
}

struct IconDrawingView: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    @Binding var toolPickerIsActive: Bool
    private let toolPicker = PKToolPicker()

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.drawing = drawing
        canvasView.delegate = context.coordinator
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = UIColor.white

        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()

        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.drawing = drawing
        toolPicker.setVisible(toolPickerIsActive, forFirstResponder: uiView)
    }

    class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: IconDrawingView

        init(_ parent: IconDrawingView) {
            self.parent = parent
        }

        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            parent.drawing = canvasView.drawing
        }
    }
}
