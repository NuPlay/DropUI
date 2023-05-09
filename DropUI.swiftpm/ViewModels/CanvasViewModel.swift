//
//  CanvasViewModel.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/09.
//

import SwiftUI

extension DragAndDropView {
    class ViewModel: ObservableObject {
        @Published var complements = ["You're doing an amazing job!", "I truly admire your hard work and dedication.", "Your positive attitude is contagious, and it really brightens up the room!"]

        @Published var dropView: [Block] = []
        @Published var complementText: String = "State"

        @Published var canvasEditing: Bool = true

        @Published var showHint: Bool = false

        func addBlock(_ block: String) {
            dropView.append(Block.fromString(block))
        }

        func removeBlock(_ index: Int) {
            dropView.remove(at: index)
        }

        func removeAll() {
            self.dropView = []
        }

        func getRandomComplement() {
            self.complementText = complements.randomElement() ?? "Your positive attitude is contagious, and it really brightens up the room!"
        }
    }
}
