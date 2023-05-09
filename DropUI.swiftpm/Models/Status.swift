//
//  Status.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/09.
//

import SwiftUI

enum Status {
    case editor
    case canvas
    case canvasEditing
}

protocol BlockView: View {
    var status: Status { get set }
}
